// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// 100000000000000000000    = 1000FAX

contract FaxenToken is ERC20, ERC20Burnable, Pausable, Ownable  {
     uint256 public _cap = 10**27;
    
    constructor() ERC20("FaxenToken", "FAX") {
        
        // Private Sale = 100M Fax
        mint(0x4637DC7c36AD7a10c0B79918eB0276B1dFc7729e, 10**26);

        // Tech Inittial  = 5M Fax
        mint(0xa910Ac56d16Fb21eeA9D144f541707E13aAcFfd3, 5 * 10**24);

        // Eco Inittial  = 5M Fax
        mint(0x7053a880d4BA54917FFE6a9A2ACce58800A3872F, 5 * 10**24);

        // Treasury = 890M FAX
        mint(0xa062D83d59e6f697Ecc5b68090ea106c5F242f23, 89 * 10**25);
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
     * @dev See {IERC20-maxSupply}.
     */
    function maxSupply() public view virtual returns (uint256) {
        return cap();
    }
 

    /**
     *  In case of any accidental deposit
     */
    ERC20 exContract;
    function withdrawBEP(address tokenContractAddress, address to, uint256 amount) public onlyOwner {
        exContract = ERC20(tokenContractAddress);
        exContract.transfer(to,amount);
    }

}
