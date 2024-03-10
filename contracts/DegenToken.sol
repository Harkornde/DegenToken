// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable{
    address public gameOwner;
    
    constructor() ERC20("Degen", "DGN") {
        gameOwner= msg.sender;  
    }

    modifier onlyOwners {
        require(msg.sender==gameOwner, "Only owner can call");
        _;
    }

    modifier hasTokens(uint256 _amount) {
        require(balanceOf(msg.sender) >= _amount, "Insufficient Degen Token");
        _;
    }

    function mintDegen(address _player, uint256 _amount) public onlyOwners  {
        _mint(_player, _amount);
    }

    function burnDegen(uint256 amount) public hasTokens(amount) {
        _burn(msg.sender, amount);
    }

    function transferDegen(address to, uint256 amount) public hasTokens(amount)  returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

     function getDegenBalance(address _owner) public view returns (uint256) {
        return super.balanceOf(_owner);
    }

    function showStore() external pure returns (string memory) {
        return "Store: 1. Health, 2. Skins, 3. Emblems";
    }

    function redeem(uint8 _Item) external payable returns (bool) {
        if (_Item == 1) {
            require(this.balanceOf(msg.sender) >= 50, "Not enough Degen Tokens to redeem");
            approve(msg.sender, 100);
            transferFrom(msg.sender, gameOwner, 50);
            return true;
        }
        else if (_Item == 2) {
            require(this.balanceOf(msg.sender) >= 25, "Not enough Degen Tokens to redeem");
            approve(msg.sender, 25);
            transferFrom(msg.sender, gameOwner, 25);
            return true;
        }
        else if (_Item == 3) {
            require(this.balanceOf(msg.sender) >= 15, "Not enough Degen Tokens to redeem");
            approve(msg.sender, 15);
            transferFrom(msg.sender, gameOwner, 15);
            return true;
        }
        else {
            return false;
        }
    }
}