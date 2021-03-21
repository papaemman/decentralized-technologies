pragma solidity ^0.5.1;

// Video timestamp " 1 - 1:13"

contract ERC20Token {
    
    string public name;
     
    // Keep track of address balance
    mapping(address => uint256) public balances;
    
    constructor(string memory _name) public {
        name = _name;
    }
    
    function mint() public {
        balances[tx.origin] ++; 
    }
}



contract MyToken is ERC20Token {
    
    string public symbol;
    address[] public owners;
    uint256 ownerCount;
    
    
    // string public name = "MyToken";
    constructor(string memory _name, string memory _symbol) ERC20Token(_name) public {
        symbol = _symbol;
    } 
    
    
    function mint() public {
        
        super.mint();
        ownerCount ++;
        owners.push(msg.sender);
    }
}


// Deployment
// MyToken contract: string: "My Token", "MTK"
