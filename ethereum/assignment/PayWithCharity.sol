// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.7;

contract PayWithCharity {

    address payable owner;
    address payable[] private charities;
    address private bestDonor;
    uint256 private highestDonation;
    uint256 public numberOfCharities;
    uint256 public totalRaised;

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can use this.");
        _;
    }

    event LogDonation(address accountAddress, uint amount);

    constructor(address payable[] memory _charities) public {
        owner = msg.sender;
        charities = _charities;
        numberOfCharities = charities.length;
        highestDonation = 0;
        totalRaised = 0;
    }

    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    function pay(address payable to, uint8 charityId) public payable returns (uint256) {
        // no need to check against the user's balance, because he's already sent the
        // amount to this payable function. If he wouldn't have the amount, the function
        // would be simply not executed
        require(charityId < numberOfCharities, "Incorrect charity ID.");
        uint256 donation = msg.value/10;
        uint256 rest = msg.value - donation;

        if (donation > highestDonation) {
            bestDonor = msg.sender;
            highestDonation = donation;
        }

        charities[charityId].transfer(donation);
        to.transfer(rest);

        emit LogDonation(msg.sender, donation);
        totalRaised += donation;

        return donation;
    }

    function pay(address payable to, uint256 donation, uint8 charityId) public payable {
        // no need to check against the user's balance, because he's already sent the
        // amount to this payable function. If he wouldn't have the amount, the function
        // would be simply not executed
        require(donation >= msg.value/100, "Donation should be at least 1% of the paying amount.");
        require(donation <= msg.value/2, "Donation cannot exceed half the amount sent.");
        require(charityId >= 0 && charityId < charities.length, "Incorrect charity ID.");

        if (donation >= highestDonation) {
            bestDonor = msg.sender;
            highestDonation = donation;
        }

        charities[charityId].transfer(donation);
        to.transfer(msg.value - donation);

        emit LogDonation(msg.sender, donation);
        totalRaised += donation;
    }

    function getHighestDonation() public onlyOwner view returns (address, uint256) {
        return (bestDonor, highestDonation);
    }

}
