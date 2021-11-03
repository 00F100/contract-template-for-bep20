# Contract Template for BEP20

This template is a example for "how to create token BEP20"

For create this contract inject into constructor parameters:

| field | type | description |
|---|---|---|
| input_name | string | Name of coin |
| input_symbol | string | Symbol of coin |
| input_decimals | uint8 | Decimals of coin |
| input_valueTax | uint256 | Value tax for all transfer |
| input_totalSupply | uint256 | Total supply of coins |

> Important: Total supply needs consider decimals
> eg: `input_totalSupply = ({total} * 10 ** {decimals})`



### Interfaces:
- IContract.sol
- IOwner.sol
- ITax.sol

### Libraries:
- Integer.sol
- SafeMath.sol

### Contract:
- OOF1OO.sol

### Contracts Internal:
- CoinManager.sol
- Ownable.sol
- Tax.sol

## Features:
- Owner for contract
- Change owner contract
- Configure tax for transfers
- Configure value and address to receive transfer tax
- Configure allowance beetwen addresses
- Create new coins of contract
- Burn coins on transfer write contract
- Burn coins by allowance
- Burn coins by address
- Safe math for add, sub, mul, div and mod operations

## Read contract:
- getOwner() - Returns owner of contract
- decimals() - Returns decimals of contract
- symbol() - Returns symbol of contract
- name() - Returns name of contract
- totalSupply() - Returns total supply of contract
- balanceOf(address account) - Returns balance of address into contract
- balanceOfOwner() - Returns balance of owner into contract
- valueTax() - Returns tax value for transfers
- taxAddress() - Returns address to receive tax value
- allowance(address owner, address spender) - Returns allowance beetwen addresses
 
## Write contract:

- setTaxAddress(address tax) - Configure address to receive tax value
- setTaxAddress() - Configure address zero for receive tax value (auto burn)
- increaseAllowance(address spender, uint256 addedValue) - Increase amount allowance beetwen addresses
- decreaseAllowance(address spender, uint256 subtractedValue) - Decrease amount allowance beetwen addresses
- approve(address spender, uint256 amount) - Configure custom amount to allowance beetwen addresses
- transfer(address recipient, uint256 amount) - Transfer amount beetwen addresses
- transferFrom(address sender, address recipient, uint256 amount) - Transfer amount from allowance beetwen addresses
- mint(uint256 amount) - Create coins and send to wallet owner
- burn(uint256 amount) - Send amount from wallet owner to address zero

## Events:

- event Transfer(address indexed from, address indexed to, uint256 value);
- event Approval(address indexed owner, address indexed spender, uint256 value);
- event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

## Modifiers:
 
 - onlyOwner - Require owner on try write contract