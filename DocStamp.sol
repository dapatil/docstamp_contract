pragma solidity ^0.4.10;

import './Owned.sol';
import './Priced.sol';


contract DocStamp is Owned, Priced {
    struct Record {
        string email;
        uint timeStamp;
    }

    // sha256 => Record
    mapping(string => Record) _records;
    uint _price;
    uint _recordCount;

    function DocStamp(uint initialPrice) {
        _price = initialPrice;
        _recordCount = 0;
    }

    // Thanks for the donation
    function () payable {
    }

    function drain() ownerOnly {
        _owner.transfer(this.balance);
    }

    function getPrice() constant returns (uint price) {
        price = _price;
    }

    function getCount() constant ownerOnly returns (uint) {
        return _recordCount;
    }

    function stampDirect(string ownerEmail, string sha) ownerOnly {
        require(!isRecorded(sha));
        
        Record memory rec = Record(ownerEmail, now);
        _records[sha] = rec;
        _recordCount = _recordCount + 1;
    }

    function stamp(string ownerEmail, string sha) payable costs(_price) {
        require(!isRecorded(sha));

        Record memory rec = Record(ownerEmail, now);
        _records[sha] = rec;
        _recordCount = _recordCount + 1;
    }

    function isRecorded(string sha) constant returns (bool) {
        return _records[sha].timeStamp != 0;
    }

    function lookup(string sha) constant returns(string, uint) {
        Record memory rec = _records[sha];
        return (rec.email, rec.timeStamp);
    }

    function updatePrice(uint newPrice) public ownerOnly {
        _price = newPrice;
    }
}
