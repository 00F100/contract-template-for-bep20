// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

/**
 * 00F100 Contract Template for BEP20
 * https://github.com/00F100/contract-template-for-bep20
 * 
 * Features:
 *     - Owner for contract
 *     - Change owner contract
 *     - Configure tax for transfers
 *     - Configure value and address to receive transfer tax
 *     - Configure allowance beetwen addresses
 *     - Create new coins of contract
 *     - Burn coins on transfer write contract
 *     - Burn coins by allowance
 *     - Burn coins by address
 *     - Safe math for add, sub, mul, div and mod operations
 * 
 * ================================================
 * 
 * Read contract:
 * 
 *     getOwner()
 *          Returns owner of contract
 * 
 *     decimals()
 *          Returns decimals of contract
 * 
 *     symbol()
 *          Returns symbol of contract
 * 
 *     name()
 *          Returns name of contract
 * 
 *     totalSupply()
 *          Returns total supply of contract
 * 
 *     balanceOf(address account)
 *          Returns balance of address into contract
 * 
 *     balanceOfOwner()
 *          Returns balance of owner into contract
 * 
 *     valueTax()
 *          Returns tax value for transfers
 * 
 *     taxAddress()
 *          Returns address to receive tax value
 * 
 *     allowance(address owner, address spender)
 *          Returns allowance beetwen addresses
 * 
 * ================================================
 * 
 * Write contract:
 * 
 *     setTaxAddress(address tax)
 *          Configure address to receive tax value
 * 
 *     setTaxAddress()
 *          Configure address zero for receive tax value (auto burn)
 * 
 *     increaseAllowance(address spender, uint256 addedValue)
 *          Increase amount allowance beetwen addresses
 * 
 *     decreaseAllowance(address spender, uint256 subtractedValue)
 *          Decrease amount allowance beetwen addresses
 * 
 *     approve(address spender, uint256 amount)
 *          Configure custom amount to allowance beetwen addresses
 * 
 *     transfer(address recipient, uint256 amount)
 *          Transfer amount beetwen addresses
 * 
 *     transferFrom(address sender, address recipient, uint256 amount)
 *          Transfer amount from allowance beetwen addresses
 * 
 *     mint(uint256 amount)
 *          Create coins and send to wallet owner
 * 
 *     burn(uint256 amount)
 *          Send amount from wallet owner to address zero
 * 
 * ================================================
 * 
 * Events:
 * 
 *     event Transfer(address indexed from, address indexed to, uint256 value);
 *     event Approval(address indexed owner, address indexed spender, uint256 value);
 *     event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
 * 
 * ================================================
 * 
 * Modifiers:
 * 
 *     onlyOwner
 *          Require owner on try write contract
 * 
 */
 
import "IContract.sol";
import "SafeMath.sol";
import "Integer.sol";
import "CoinManager.sol";

contract OOF1OO is IContract, CoinManager {
    /**
     * @dev Apply modifiers into `uint256` type
     */
    using SafeMath for uint256;
    using Integer for uint256;
    
    /**
     * @dev Create contract
     * 
     * Notes:
     *    - input_name is a "name of coin"
     *    - input_symbol is a "COIN" symbol
     *    - input_decimals is a "18" or other number
     *    - input_valueTax: tax value to apply all transfers
     *    - input_totalSupply is a number of total supply with decimals
     *        eg: total: 100, decimals: 2
     *            (100 * 10 ** 2)
     *            "10000" is correct input_totalSupply for create 100 coins
     */
    constructor(
        string memory input_name,
        string memory input_symbol,
        uint8 input_decimals,
        uint256 input_valueTax,
        uint256 input_totalSupply
    ) {
        _name = input_name;
        _symbol = input_symbol;
        _decimals = input_decimals;
        _valueTax = input_valueTax;
        _totalSupply = input_totalSupply;
        _balances[msg.sender] = input_totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
    /**
     * @dev Returns owner address of contract
     */
    function getOwner() external view returns (address) {
        return owner();
    }
    /**
     * @dev Returns decimals of contract
     */
    function decimals() external view returns (uint8) {
        return _decimals;
    }
    /**
     * @dev Returns symbol of contract
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }
    /**
     * @dev Returns name of contract
     */
    function name() external view returns (string memory) {
        return _name;
    }
    /**
     * @dev Returns total coin supply of contract
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }
    /**
     * @dev Returns balance of address
     */
    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }
    /**
     * @dev Returns balance of owner address
     */
    function balanceOfOwner() external view returns (uint256) {
        return _balances[owner()];
    }
    /**
     * @dev Returns allowance beetwen addresses
     */
    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }
    /**
     * @dev Increment allowance beetwen addresses
     */
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }
    /**
     * @dev Decrease allowance beetwen addresses
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "BEP20: decreased allowance below zero"));
        return true;
    }
    /**
     * @dev Configure allowance beetwen addresses
     */
    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }
    /**
     * @dev Transfer amount beetwen addresses
     */
    function transfer(address recipient, uint256 amount) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }
    /**
     * @dev Transfer amount allowance beetwen addresses
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "BEP20: transfer amount exceeds allowance"));
        _transfer(sender, recipient, amount);
        return true;
    }
    /**
     * @dev Create coins into supply and send for owner contract
     */
    function mint(uint256 amount) external onlyOwner returns (bool) {
        _mint(msg.sender, amount);
        return true;
    }
    /**
     * @dev Burn coins from sender
     */
    function burn(uint256 amount) external returns (bool) {
        _burn(msg.sender, amount);
        return true;
    }
}
