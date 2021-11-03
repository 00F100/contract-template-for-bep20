// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

interface ITax {
    /**
     * @dev Returns the value tax in percentage
     * 
     * Default is "0"
     */
    function valueTax() external view returns(uint256);
    /**
     * @dev Returns the tax address
     * 
     * Default is "address(0)"
     */
    function taxAddress() external view returns(address);
    /**
     * @dev Configure tax value for all {transfer} call send percentage to {taxAddress}
     * 
     * This value will be used to calculate the percentage
     */
    function setValueTax(uint8 value) external returns (bool);
    /**
     * @dev Configure address to receive tax amount
     */
    function setTaxAddress(address tax) external returns (bool);
    /**
     * @dev Configure address for "zero address" to burn tax
     */
    function setTaxAddress() external returns (bool);
}