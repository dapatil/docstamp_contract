pragma solidity ^0.4.10;


contract Priced {
    // Modifiers can receive arguments:
    
    modifier costs(uint price) {
        if (msg.value >= price) {
            _;
        }
    }
}
