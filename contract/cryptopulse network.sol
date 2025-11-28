// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptopulseNetwork {
    string public networkName;
    address public owner;

    // Event for new transaction
    event TransactionProcessed(address indexed sender, uint256 amount, string message);

    // Mapping to store user balances
    mapping(address => uint256) public balances;

    constructor(string memory _networkName) {
        networkName = _networkName;
        owner = msg.sender;
    }

    // Function to deposit funds into the network
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // Function to withdraw funds from the network
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Function to send funds to another user and log the transaction
    function sendTransaction(address recipient, uint256 amount, string memory message) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;

        emit TransactionProcessed(msg.sender, amount, message);
    }

    // Helper function to check contract balance
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

