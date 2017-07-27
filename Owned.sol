pragma solidity ^0.4.10;


contract Owned {
    address _owner;

    function Owned() {
        _owner = msg.sender;
    }

    modifier ownerOnly() {
        if (msg.sender == _owner)
            _;
    }

    function getOwner()  constant public returns (address ownerAddress) {
        ownerAddress = _owner;
    }

    function transferOwnership(address newOwner) ownerOnly {
        _owner = newOwner;
    }
}
