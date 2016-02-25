# Test Splittable [![Build Status](https://travis-ci.org/fquffio/test-splittable.svg?branch=master)](https://travis-ci.org/fquffio/test-splittable)

This repository is a Composer project that contains two packages that can be splitted and uploaded to their own GitHub repositories.

## Splitting

Every time you push to `master`, you should stash your current changes, then run `make components` to update every component's repository.

## Components

- `fquffio/test-package1` ([source](https://github.com/fquffio/test-package1))
- `fquffio/test-package2` ([source](https://github.com/fquffio/test-package2))
