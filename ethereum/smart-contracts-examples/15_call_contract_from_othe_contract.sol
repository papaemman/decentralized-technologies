pragma solidity ^0.5.1;

// Video timestamp " 1 - 1:13"

contract ERC20Token {
    
    string public name;
     
    // Keep track of address balance
    mapping(address => uint256) public balances;
    
    function mint() public {
        balances[msg.sender] ++; // tx.origin instead of msg.sender
    }
}



contract MyContract {
    
    //Define a variable wallet (address type and payable)
    address payable wallet;
    address public token;
    
    // In contract deployment I have to pass a wallet argument (address) 
    // and this will be the wallet we keep track the balance
    constructor(address payable _wallet, address _token) public {
        wallet = _wallet;
        token = _token;
    }
    
    function() external payable {
        buyToken();
    }
    
    // function that acceppts ether    
    function buyToken() public payable {
        ERC20Token _token = ERC20Token(address(token)); // OR ERC20Token(address(token)).mint();
        _token.mint();
        wallet.transfer(msg.value);
    }
}



