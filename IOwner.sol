// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface IOwner {
    /**
     * @dev Renounce ownership of contract and promove address zero for that
     */
    function renounceOwnership() external;
    /**
     * @dev Transfer ownership of contract for another address
     *
     * Requirements
     *
     * - `newOwner` cannot be the zero address
     */
    function transferOwnership(address newOwner) external;
    /**
     * @dev Emitted on execute transfer ownership of contract
     */
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
}