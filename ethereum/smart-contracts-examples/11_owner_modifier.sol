pragma solidity ^0.5.1;

contract MyContract {
    
    // TASK:
    
    // Allow only to contract owner to use addPerson function
    // If I try to use the addPerson function from a different address
    // from the address I had used for contract deployment,
    // this will throw an error
    
    
    // Define variables
    
    address owner;
    
    uint256 public peopleCount = 0;
    
    mapping(uint => Person) public people;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    struct Person {
        uint _id;
        string _firstName;
        string _lastName;
    }   
    
    // constructor will be run at the contract deployement, in order to get the owner's address
    constructor() public {
        owner = msg.sender;    
        
    }
    
    function addPerson(string memory _firstName, string memory _lastName) public onlyOwner {
        incrementCount();
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }
    
    function incrementCount() internal {
        peopleCount += 1;
    }
    
}