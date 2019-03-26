pragma solidity ^0.4.2;
contract Lottery{
    address[] public players;
    address public manager;
    
    constructor() public{
        manager=msg.sender;
    }   
    function() payable external {
        require(msg.value >= 0.01 ether);
        players.push(msg.sender);
    }
    function get_balance()public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;
    }
    function random() public view returns(uint256){
        return uint256(keccak256( abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }
    function selectWinner() public {
        require(msg.sender==manager);
        uint r= random();
        address winner;
        uint index=r % players.length;
        winner=players[index];
        winner.transfer(address(this).balance);
        players= new address[](0);
        
        
    }
}
