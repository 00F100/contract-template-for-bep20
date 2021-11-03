// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface IContract {
    /**
     * @dev Returns address owner
     */
    function getOwner() external view returns (address);
    /**
     * @dev Returns token decimals
     */
    function decimals() external view returns (uint8);
    /**
     * @dev Returns token symbol
     */
    function symbol() external view returns (string memory);
    /**
     * @dev Returns token name
     */
    function name() external view returns (string memory);
    /**
     * @dev Returns token total supply
     */
    function totalSupply() external view returns (uint256);
    /**
     * @dev Returns the amount of tokens owned by `account`
     */
    function balanceOf(address account) external view returns (uint256);
    /**
     * @dev Returns the amount of tokens owned by token owner
     */
    function balanceOfOwner() external view returns (uint256);
    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default
     *
     * This value changes when {approve} or {transferFrom} are called
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address
     * - `spender` cannot be the zero address
     */
    function allowance(address owner, address spender) external view returns (uint256);
    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller
     *
     * This is an alternative to {approve} that can be used as a mitigation
     *
     * Emits an {Approval} event indicating the updated allowance
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller
     *
     * This is an alternative to {approve} that can be used as a mitigation
     *
     * Emits an {Approval} event indicating the updated allowance
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
    /**
     * @dev Manual configure allowance granted to `spender`
     * 
     * Emits an {Approval} event indicating the updated allowance
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address
     */
    function approve(address spender, uint256 amount) external returns (bool);
    /**
     * @dev Transfer amount for any address
     * 
     * If {valueTax} configured the {taxAddress} receive tax amount
     * 
     * Requirements:
     *
     * - `recipient` cannot be the zero address
     */
    function transfer(address recipient, uint256 amount) external returns (bool);
    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     * 
     * If {valueTax} configured the {taxAddress} receive tax amount
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    /**
     * @dev Creates `amount` tokens and assigns them to `msg.sender`, increasing
     * the total supply.
     *
     * Requirements
     *
     * - `msg.sender` must be the token owner
     */
    function mint(uint256 amount) external returns (bool);
    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function burn(uint256 amount) external returns (bool);
}