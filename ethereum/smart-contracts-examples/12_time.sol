pragma solidity ^0.5.1;

contract MyContract {
    
    // TASK:
    
    // Allow only to contract owner to use addPerson function
    // If I try to use the addPerson function from a different address from the address I had used for contract deployment,
    // this will throw an error
    
    
    // Define variables
    
    address owner;
    
    uint256 public peopleCount = 0;
    
    uint256 openingTime=1590255151;
    
    mapping(uint => Person) public people;
    
    modifier onlyWhileOpen() {
        require(block.timestamp >= openingTime);
        _;
    }
    
    struct Person {
        uint _id;
        string _firstName;
        string _lastName;
    }   
    
    
    function addPerson(string memory _firstName, string memory _lastName) public onlyWhileOpen {
        incrementCount();
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }
    
    function incrementCount() internal {
        peopleCount += 1;
    }
    
}