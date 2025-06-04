// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    
    mapping(address => uint256) private balances;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable { }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "Must deposit more than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount*1 ether, "Insufficient balance");
        balances[msg.sender] -= amount*1 ether;
        payable(msg.sender).transfer(address(this).balance);
    }

    function getMyBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function getUserBalance(address user) public view onlyOwner returns (uint256) {
        return balances[user];
    }

    function transferTo(address recipient, uint256 amount) public {
        require(balances[msg.sender] >= amount*1 ether, "Insufficient balance");

        balances[msg.sender] -= amount*1 ether;
        balances[recipient] += amount*1 ether;
    }
}
