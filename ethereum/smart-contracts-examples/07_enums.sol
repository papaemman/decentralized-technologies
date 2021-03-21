pragma solidity ^0.5.1;

contract MyContract {
    
    // Enumarated list - Help us keep track the state of the contract
    enum State { Waiting, Ready, Active }
    State public state;
    
    // constructor will be run when the contract first deployed
    constructor() public {
        state = State.Waiting;
    }
    
    // Activate the state
    function activate() public {
        state = State.Active;
    }
    
    // Check what is the current State
    function check_state() public view returns(bool) {
        return state == State.Active;
    }
}