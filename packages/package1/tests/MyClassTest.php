<?php

namespace Fquffio\TestPackage1\Test;

use \Fquffio\TestPackage1\MyClass;

/**
 * Test `MyClass` class.
 */
class MyClassTest extends \PHPUnit_Framework_TestCase
{

    /**
     * Test `__toString()` method.
     */
    public function testToString()
    {
        $instance = new MyClass();
        $this->assertEquals('Fquffio\\TestPackage1\\MyClass', (string)$instance);
    }
}
