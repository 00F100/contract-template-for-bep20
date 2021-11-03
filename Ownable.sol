// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "IOwner.sol";

contract Ownable is IOwner {
    /**
     * @dev Owner for this contract
     */
    address private _owner;
    /**
     * @dev On construct define owner for contract
     * 
     * For change owner see {transferOwnership} or {renounceOwnership}
     */
    constructor () {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }
    /**
     * @dev Modifier to add permission for owner on try write contract
     */
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }
    /**
     * @dev Renounce ownership of contract and promove address zero for that
     */
    function renounceOwnership() external onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    /**
     * @dev Transfer ownership of contract for another address
     *
     * Requirements
     *
     * - `newOwner` cannot be the zero address
     */
    function transferOwnership(address newOwner) external onlyOwner {
        _transferOwnership(newOwner);
    }
    /**
     * @dev Transfer ownership of contract for another address
     *
     * Requirements
     *
     * - `newOwner` cannot be the zero address
     */
    function _transferOwnership(address newOwner) private {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
    /**
     * @dev Return address of contract owner
     */
    function owner() internal view returns (address) {
        return _owner;
    }
}