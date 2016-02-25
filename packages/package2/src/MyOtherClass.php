<?php

namespace Fquffio\TestPackage2;

/**
 * An example class.
 */
class MyOtherClass
{

    /**
     * An example method.
     *
     * @return string
     */
    public function __toString()
    {
        return __CLASS__ . '::' . __METHOD__ . '()';
    }
}
