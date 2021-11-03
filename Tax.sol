// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "ITax.sol";
import "Ownable.sol";

contract Tax is ITax, Ownable {
    /**
     * @dev Value tax in percent
     */
    uint256 internal _valueTax;
    /**
     * @dev Address to receive tax
     */
    address internal _taxAddress = address(0);
    /**
     * @dev Returns value tax in percent
     */
    function valueTax() external view returns(uint256) {
        return _valueTax;
    }
    /**
     * @dev Returns address to receive tax
     */
    function taxAddress() external view returns(address) {
        return _taxAddress;
    }
    /**
     * @dev Configure value to tax, in percent
     */
    function setValueTax(uint8 value) external onlyOwner returns (bool) {
        _valueTax = value;
        return true;
    }
    /**
     * @dev Configure address to receive tax
     */
    function setTaxAddress(address tax) external onlyOwner returns (bool) {
        _taxAddress = tax;
        return true;
    }
    /**
     * @dev Configure address zero to receive tax
     */
    function setTaxAddress() external onlyOwner returns (bool) {
        _taxAddress = address(0);
        return true;
    }
}