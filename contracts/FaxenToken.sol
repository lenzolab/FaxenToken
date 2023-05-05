// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// 100000000000000000000    = 1000FAX

contract FaxenToken is ERC20, ERC20Burnable, Pausable, Ownable  {
     uint256 private immutable _cap;
    
    constructor() ERC20("FaxenToken", "FAX") {
        _cap = 10**27;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20: cap exceeded");
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    /**
     * @dev Returns the cap on the token's total supply.
     */
    function cap() public view virtual returns (uint256) {
        return _cap;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function maxSupply() public view virtual returns (uint256) {
        return cap();
    }
}
