<?php

namespace Fquffio\TestSplittable\Test;

use \Fquffio\TestSplittable\Together;

/**
 * Test `Together` class.
 */
class TogetherTest extends \PHPUnit_Framework_TestCase
{

    /**
     * Test `first()` method.
     */
    public function testFirst()
    {
        $instance = new Together();
        $this->assertEquals('Fquffio\\TestPackage1\\MyClass', $instance->first());
    }

    /**
     * Test `second()` method.
     */
    public function testSecond()
    {
        $instance = new Together();
        $this->assertEquals('Fquffio\\TestPackage2\\MyOtherClass::__toString()', $instance->second());
    }
}
