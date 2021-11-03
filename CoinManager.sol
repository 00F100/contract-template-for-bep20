// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "Tax.sol";
import "SafeMath.sol";
import "Integer.sol";

contract CoinManager is Tax {
    /**
     * @dev Apply modifiers into `uint256` type
     */
    using SafeMath for uint256;
    using Integer for uint256;
    /**
     * @dev Balance of coins by `address`
     */
    mapping (address => uint256) internal _balances;
    /**
     * @dev Allowances of coins by `address`
     * 
     * See example:
     * 
     * {sender} = address origin amount
     * {recipient} = address destination amount
     * 
     * mapping ({sender} => mapping ({recipient} => uint256))
     */
    mapping (address => mapping (address => uint256)) internal _allowances;
    /**
     * @dev Total of coins for contract
     * 
     * This value may be change by {_mint()}
     */
    uint256 internal _totalSupply;
    /**
     * @dev Returns decimals of coint
     * 
     * This value not be changed after contract create
     */
    uint8 internal _decimals;
    /**
     * @dev Returns symbol of coint
     * 
     * This value not be changed after contract create
     */
    string internal _symbol;
    /**
     * @dev Returns name of coint
     * 
     * This value not be changed after contract create
     */
    string internal _name;
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);
    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
    /**
     * @dev Transfer amount beetwen addresses
     * 
     * Notes:
     *    - Sender or recipient not be address(0)
     *    - If have tax and not address for receive tax
     *      remove from {_totalSupply} before send to burn
     */
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "BEP20: transfer from the zero address");
        require(recipient != address(0), "BEP20: transfer to the zero address");
        
        _balances[sender] = _balances[sender].sub(amount, "BEP20: transfer amount exceeds balance");
        
        if (_valueTax > 0) {
            uint256 tax = amount.percent(_valueTax);
            amount = amount.sub(tax, "BEP20: Tax exceeds amount");
            if (_taxAddress == address(0)) {
                _totalSupply = _totalSupply.sub(tax, "BEP20: tax amount exceeds total supply");
            } else {
                _balances[_taxAddress] = _balances[_taxAddress].add(tax);
            }
            emit Transfer(sender, _taxAddress, amount);
        }
        
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }
    /**
     * @dev Create coins for contract
     * 
     * Notes:
     *    - Not be create coins for address(0)
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "BEP20: mint to the zero address");
        
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }
    /**
     * @dev Send coins of address to address(0)
     * 
     * Notes:
     *    - The account not be address(0)
     */
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "BEP20: burn from the zero address");
        
        _balances[account] = _balances[account].sub(amount, "BEP20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount, "BEP20: burn amount exceeds total supply");
        emit Transfer(account, address(0), amount);
    }
    /**
     * @dev Configure allowance beetwen addresses
     * 
     * Notes:
     *    - The owner and spender not be address(0)
     *    - The owner must have balance
     */
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "BEP20: approve from the zero address");
        require(spender != address(0), "BEP20: approve to the zero address");
        require(_balances[owner] >= amount, "BEP20: approve from not have balance");
        
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}