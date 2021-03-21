pragma solidity ^0.5.1;

contract MyContract {
    
    // Keep track of address balance
    mapping(address => uint256) public balances;
    
    //Define a variable wallet (address type and payable)
    address payable wallet;
    
    // In contract deployment I have to pass a wallet argument (address) 
    // and this will be the wallet we keep track the balance
    constructor(address payable _wallet) public {
        wallet = _wallet;
    }
    

    // function that acceppts ether    
    function buyToken() public payable {
        
        // buy a token from the message sender
        balances[msg.sender] += 1;
        
        // send ether from msg sender to the initial wallet
        // msg.value defines the ammount of ether
        wallet.transfer(msg.value);
        
    }
}


// DOCUMENTATION

// contract deployment:
// I need to pass an address (wallet) as argument while deploying this contract,
// as one can see in constructor. 
// This will be my wallet, that I will keep track of.


// From a different address, I will call the buyToken() function, to transfer funds from this address to the original address.

// Note: If I try to run this contract, I will examine that there is no change in the balance of my adress
// I have to change the value to 1 and wei -> ether to see the difference.

