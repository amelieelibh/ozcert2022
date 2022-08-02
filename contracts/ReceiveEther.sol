// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract ReceiveEther {

    // transfer 2.3k gas, without return, otherwise fails
    function sendEtherTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    // send 2.3k gas, returns bool
    function sentEtherSend(address payable _to) public payable returns(bool){
        bool sent = _to.send(msg.value);
        require(sent, "Could not send ether");
        return sent;
    }

    //call 2.3k gas, returns bool and data
    function sendEtherCall(address payable _to) public payable returns(bool) {
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        console.log("data", string(data));
        require(sent, "Could not send ether");
        return sent;
    }
}