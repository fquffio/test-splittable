<?php

namespace Fquffio\TestSplittable;

use Fquffio\TestPackage1\MyClass;
use Fquffio\TestPackage2\MyOtherClass;

/**
 * Test the two classes.
 */
class Together
{

    /**
     * First class instance.
     *
     * @var \Fquffio\TestPackage1\MyClass
     */
    protected $class;

    /**
     * Second class instance.
     *
     * @var \Fquffio\TestPackage2\MyOtherClass
     */
    protected $otherClass;

    /**
     * Constructor.
     */
    public function __construct()
    {
        $this->class = new MyClass();
        $this->otherClass = new MyOtherClass();
    }

    /**
     * Represent first as a string.
     *
     * @return string
     */
    public function first()
    {
        return (string)$this->class;
    }

    /**
     * Represent second as a string.
     *
     * @return string
     */
    public function second()
    {
        return (string)$this->otherClass;
    }
}
