// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

library Integer {
   /**
    * @dev Returns percent of value uint
    *
    * "a" input is percent and "b" total amount
    */
    function percent(uint256 a, uint256 b) internal pure returns (uint256) {
        return (b * a) / 100;
    }
}