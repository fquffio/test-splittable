<?php

namespace Fquffio\TestPackage2\Test;

use \Fquffio\TestPackage2\MyOtherClass;

/**
 * Test `MyOtherClass` class.
 */
class MyOtherClassTest extends \PHPUnit_Framework_TestCase
{

    /**
     * Test `__toString()` method.
     */
    public function testToString()
    {
        $instance = new MyOtherClass();
        $this->assertEquals('Fquffio\\TestPackage2\\MyOtherClass::__toString()', (string)$instance);
    }
}
