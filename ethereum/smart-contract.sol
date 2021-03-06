pragma solidity ^0.6.1;

// "SPDX-License-Identifier: UNLICENSED

// Solidity DOCUMENTATION : https://solidity.readthedocs.io/en/v0.6.8/index.html
// Solidity Source code   : https://github.com/ethereum/solidity/


// INSTRUCTIONS //

// When you deploy the contract, you have to specify a list of charities.
// For example: ["0x8108AB5039fe2e551565e7fAe2bEff73C4778621", "0xE94F5CC6798b9aDc1A54d1806F7EC84eA056a6A5", "0xB37E2b285aC7Dc822abD500bA3Eb42faC2f7e3d1"]

// All transaction must be done in wei!
// msg.value: Number of wei sent with the message.

// About the requirement "The contract should make appropriate checks if the user that originated the transfer has sufficient funds",
// there isn't a need to make any checks for that because the transaction will not be possible if the user doesn'y have sufficient funds.



// Assignment 2, 2020 - Ethereum //


// TASK: 

// The smart contract's purpose is to facilitate donations to different charities. 
// When a user wants to send some funds to a destination address,
// instead of sending them directly to that address, they will use the smart contract.
// A part of the funds will be sent to the charity the user specified, while the rest will go to the destination address.


// In order to accomplish that, you will need to code a contract that 
// - when deployed, will accept a list of charities at creation time, specified by their respective addresses.

// For facilitating the transfer of funds,
// - you will code two different variations of the same method. 

// The users that would want to donate, will then make their payments by sending funds to these methods.


// In the first variation, the method that facilitates the payments, 
// 1. will accept a destination address, as well as the index number of the charity (0 is the index for the first charity, 1 for the second etc).
// 2. The method should redirect 10% of the funds to the selected charity, while transferring the rest to the destination address. 
// The contract should make appropriate checks 
// - if the user that originated the transfer has sufficient funds and 
// - if the charity index number that is provided is a valid one.


// In the second variation,
// 1. the method will additionally accept a value for the donated amount (in wei).
// In addition to the checks that the previous variation performs, in this case,
// - it should also check that the donated amount is within acceptable limits; 
//   a donation has to be at least 1% of the total transferred amount, while it cannot exceed half of the total transferred amount.


// The contract should 
// 1. keep track of the total amount raised by all donations (in wei) and towards any charity, collectively, 
// 2. and provide means for any interested party to access that information.

// So, for example,
// if one donation of 2 ether has been made to charity A
// and another donation of 3 ether was made to charity B, 
// the contract should report that 5 ether was donated in total.

// The contract should also
// 3. keep track of who is the person that made the highest donation, identified by their address, along with the amount they donated.
// - This information should be available with a single call to one method in the contract.
//   It should also be available only to the user that deployed the contract.

// When a donation has been made through the contract, 
// - an event transmitting the address of the donor and the amount donated, should be emitted.

// - You will also have to provide some means to destroy the contract and render it unusable.
//   This functionality should be available only to the user that deployed the contract.


// Notes:
// - Use method overloading for providing two different variations of the same method that facilitates the transfer of funds.
// - Use a modifier to restrict access to functionality.
// - The addresses of the charities should not be publicly available.
// - Your submissions should include only the .sol file with the smart contract.
// - Comment your code detailing your design choices.
// - Submit only the .sol source code file inside a compressed archive (.zip, .tar.gz etc).


contract MyContract {

    
    // Keep the contract's owner address
    address private owner;
    
    // Chartity data structure (address, index)
    struct Charity {
        address payable name;
        uint index;           
    }
    
    // Array for charity adresses
    Charity[] private charities;
    
    // keep track the highestDonation 
    struct HighestDonation {
        address user_address;
        uint amount_donated;
    }
    
    HighestDonation highestDonation;

    // Keep track of the total_donations
    uint total_donations;


    // Declare a Donation event to be displayed in logs every time a donation happened
    event Donation(address _user, uint _amount);
    
    
    // Define a modifier to restrict the usage of certain methods only to contract's owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
        
    // Define a constructor to be runned when the constract be deployed for the first time.
    // When the contract deployed, will accept a list of charities at creation time, specified by their respective addresses.
    constructor(address payable[] memory charitiesAddresses) public {
        
        owner = msg.sender;
        highestDonation = HighestDonation(msg.sender, 0); // initialize the highestDonation (with the owner's address and zero value)
        
        
        for (uint i = 0; i < charitiesAddresses.length; i++) {
            
            charities.push(Charity({
                name: charitiesAddresses[i],
                index: i
            }));
        }
    }
    
   
    
    // There are two different variations of the same method (overloading)
    // The specific method which will be used depends on the arguments called by the user 
    
    
    function send_funds_to_address(address payable _destination_address, uint _charity_index) public payable {
    
        // In the first variation, the method that facilitates the payments, 
        // 1. will accept a destination address, as well as the index number of the charity (0 is the index for the first charity, 1 for the second etc).
        // 2. The method should redirect 10% of the funds to the selected charity, while transferring the rest to the destination address. 
        // The contract should make appropriate checks 
        // - if the user that originated the transfer has sufficient funds and (don't need it)
        // - if the charity index number that is provided is a valid one.

        uint charity_donation;
        
        require(_charity_index < charities.length);
        
        // - Send the 90% of the funds (wei) from msg.sender to the specified address
        // - msg.value specifies the ammount to send in wei
        
        _destination_address.transfer(9 * (msg.value/10));
        
        // Send the remaining 10% of the funds to charity address
        Charity storage c = charities[_charity_index];
        charity_donation = 1 * (msg.value/10);
        c.name.transfer(charity_donation);
        
        // Display event at logs
        emit Donation(msg.sender, charity_donation);
        
        // Check if current donation exceeds the highest donation and update it if so.
        if(highestDonation.amount_donated < charity_donation){
            highestDonation = HighestDonation(msg.sender, charity_donation);
        }
        
        // Add the current charity donation value to total_donations
        total_donations = total_donations + charity_donation;
        
    }
    
    
    
    function send_funds_to_address(address payable _destination_address, uint _charity_index, uint _charity_amount) public payable {
        
        // In the second variation,
        // 1. the method will additionally accept a value for the donated amount (in wei).
        // In addition to the checks that the previous variation performs, in this case,
        // - it should also check that the donated amount is within acceptable limits; 
        //   a donation has to be at least 1% of the total transferred amount, while it cannot exceed half of the total transferred amount.

        
        require(_charity_index < charities.length);
        
        require ( ((msg.value/100) <= _charity_amount)  &&  (_charity_amount <= (msg.value/2)) );
        
        
        // Send funds - charity ammount to destination address
        _destination_address.transfer(msg.value - _charity_amount);
        
        // Send the charity ammount to charity address
        Charity storage c = charities[_charity_index];
        c.name.transfer(_charity_amount);
        
        // Display event at logs
        emit Donation(msg.sender, _charity_amount);
        
        // Check if current donation exceed the highest donation and update it if so.
        if(highestDonation.amount_donated < _charity_amount){
            highestDonation = HighestDonation(msg.sender, _charity_amount);
        }
        
        // Add the current charity donation value to total_donations
        total_donations = total_donations + _charity_amount;
    }
    
    
    // Report Highest Donation
    function checkHighestDonation() public view onlyOwner returns(address, uint) {
      return (highestDonation.user_address, highestDonation.amount_donated);
    }
    
    // Report Total donations
    function checkTotalDonations() public view returns (uint){
        return(total_donations);
    }
    
    // Destructor
    function destroy() public onlyOwner {
        selfdestruct(msg.sender);
    }
    
 
    
}
