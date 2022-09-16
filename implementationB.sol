// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import './proxiable.sol';

contract implementationB is Proxiable, ERC20("DutchManThing", "DMT") {

     address public  _owner = address(1);

    function constructor1() public{
        // ensures this can be called only once per *proxy* contract deployed
        require(_owner == address(0));
        _owner = msg.sender;
        _mint(address(this), 100000);
    }

    function mint_ (address to, uint256 amount) public  {
        ERC20._mint(to, amount);
    }

    function balance() public view returns(uint256){
        return address(this).balance;
    }

    function _transfer(address to, uint256 amount) public {
        ERC20.transferFrom(address(this), to, amount);
    }

    function burn(uint amount) public {
        ERC20._burn(address(0), amount);
    }

    function encode() external pure returns(bytes memory) {
        return abi.encodeWithSignature("constructor1()");
    }

    function updateCode(address newCode) public   {
        updateCodeAddress(newCode);
    }

}
