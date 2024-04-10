// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageAndTransfer {
    string public message;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function setMessage(string memory newMessage) public payable {
        message = newMessage;
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function transferTo(address payable recipient, uint256 amount) public {
        require(msg.sender == owner, "Only the owner can transfer funds");
        recipient.transfer(amount);
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}
