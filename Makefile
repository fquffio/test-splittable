# The following env variables need to be set:
# - VERSION
# - GITHUB_USER
# - GITHUB_TOKEN (optional if you have two factor authentication in github)

# Use the version number to figure out if the release is a pre-release
PRERELEASE=$(shell echo $(VERSION) | grep -E 'dev|rc|alpha|beta' --quiet && echo 'true' || echo 'false')
COMPONENTS= package1 package2
COMPONENTS_DIR=packages
COMPONENTS_PREFIX=test-
CURRENT_BRANCH=$(shell git branch | grep '*' | tr -d '* ')

# Github settings
UPLOAD_HOST=https://uploads.github.com
API_HOST=https://api.github.com
OWNER=fquffio
REMOTE=origin

ifdef GITHUB_TOKEN
	AUTH=-H 'Authorization: token $(GITHUB_TOKEN)'
else
	AUTH=-u $(GITHUB_USER) -p$(GITHUB_PASS)
endif

DASH_VERSION=$(shell echo $(VERSION) | sed -e s/\\./-/g)

ALL: help
.PHONY: help test need-version bump-version tag-version

help:
	@echo "BEdita Makefile"
	@echo "==============="
	@echo ""
	@echo "release"
	@echo "  Create a new release of BEdita. Requires the VERSION and GITHUB_USER, or GITHUB_TOKEN parameter."
	@echo ""
	@echo "components"
	@echo "  Split each of the public namespaces into separate repos and push the to Github."
	@echo ""
	@echo "test"
	@echo "  Run the tests for BEdita."
	@echo ""
	@echo "All other tasks are not intended to be run directly."


# Utility target for checking required parameters
guard-%:
	@if [ "$($*)" = '' ]; then \
		echo "Missing required $* variable."; \
		exit 1; \
	fi;


# Run test suite
test:
	curl -sS https://getcomposer.org/installer | php
	php composer.phar install
	vendor/bin/phpunit


# Version bumping & tagging for BEdita itself
# Update VERSION.txt to new version.
bump-version: guard-VERSION
	@echo "Update VERSION.txt to $(VERSION)"
	# Work around sed being bad.
	mv VERSION.txt VERSION.old
	cat VERSION.old | sed s'/^[0-9]\.[0-9]\.[0-9].*/$(VERSION)/' > VERSION.txt
	rm VERSION.old
	git add VERSION.txt
	git commit -m "Update version number to $(VERSION)"

# Tag a release
tag-release: guard-VERSION bump-version
	@echo "Tagging $(VERSION)"
	git tag -s $(VERSION) -m "BEdita $(VERSION)"
	git push $(REMOTE)
	git push $(REMOTE) --tags

# Tasks for publishing separate repositories out of each BEdita namespace
components: $(foreach component, $(COMPONENTS), component-$(component))
components-tag: $(foreach component, $(COMPONENTS), tag-component-$(component))

component-%:
	git checkout $(CURRENT_BRANCH) > /dev/null
	- (git remote add $* git@github.com:$(OWNER)/$(COMPONENTS_PREFIX)$*.git -f 2> /dev/null)
	- (git branch -D $* 2> /dev/null)
	git checkout -b $*
	git filter-branch --prune-empty --subdirectory-filter $(COMPONENTS_DIR)/$(shell php -r "echo strtolower('$*');") -f $*
	git push -f $* $*:$(CURRENT_BRANCH)
	git checkout $(CURRENT_BRANCH) > /dev/null

tag-component-%: component-% guard-VERSION guard-GITHUB_USER
	@echo "Creating tag for the $* component"
	git checkout $*
	curl $(AUTH) -XPOST $(API_HOST)/repos/$(OWNER)/$*/git/refs -d '{ \
		"ref": "refs\/tags\/$(VERSION)", \
		"sha": "$(shell git rev-parse $*)" \
	}'
	git checkout $(CURRENT_BRANCH) > /dev/null
	git branch -D $*
	git remote rm $*

# Top level alias for doing a release.
release: guard-VERSION guard-GITHUB_USER tag-release components-tag
