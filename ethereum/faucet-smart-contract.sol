pragma solidity ^0.6.1;

/* Our first contract is a faucet */
contract Faucet {

    // Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {
        // Limit withdrawal amount
        require(withdraw_amount <= 100000000000000000);
        // Send the amount to the address that requested it
        msg.sender.transfer(withdraw_amount);
    }
    
    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    // Accept any incoming amount
    receive() external payable {}
}