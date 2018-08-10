pragma solidity ^0.4.23;

contract Bet {
    address public owner;
    uint256 public minimumBet;
    uint256 public totalBet;
    uint256 public numberOfBets;
    uint256 public maxTime = 100;
    uint256 public odds = 3 / 1;
    address[] public players;

    struct Player {
        uint256 amountBet;
        uint256 selected;
    }

    mapping(address => Player) public playerInfo;

   function() public payable {}

    function Bet(uint256 _minimumBet) public {
        owner = msg.sender;
        if (_minimumBet != 0) minimumBet = _minimumBet;
    }

    function kill() public {
        if (msg.sender == owner)
    selfdestruct(owner);
    }

    function checkPlayerExists(address player) public constant returns (bool) {
        for (uint256 i = 0; i < players.length; i++) {
            if (players[i] == player) return true;
        }
        return false;
    }

    function betting(uint256 selected) public payable {
        require(!checkPlayerExists(msg.sender));
        require(selected >= 1 && selected <= 2);
        require(msg.value >= minimumBet);

        playerInfo[msg.sender].amountBet = msg.value;
        playerInfo[msg.sender].selected = selected;
        numberOfBets++;
        players.push(msg.sender);
        totalBet += msg.value;
    }



    function distributePrizes(uint256 numberWinner) public {
        address[100] memory winners;

        uint256 count = 0;

        for (uint256 i = 0; i < players.length; i++) {
            address playerAddress = players[i];
            if (playerInfo[playerAddress].numberSelected == numberWinner) {
                winners[count] = playerAddress;
                count++;
            }
            delete playerInfo[playerAddress];
        }

        players.length = 0;

        uint256 winnerEtherAmount = totalBet / winners.length;
        // NEED TO CALCULATE AND FACTOR IN ODDS!

        for(uint256 j = 0; j < count; j++) {
            if (winners[j] !== address(0))
                winners[j].transfer(winnerEtherAmount);
        }
    }
}

