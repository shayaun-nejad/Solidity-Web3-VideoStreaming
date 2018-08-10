pragma solidity ^0.4.10;

contract Ownable {
    address owner;
    function Ownable() public {
        owner = msg.sender;
    }


    modifier Owned {
        require(msg.sender == owner);
        _;
    }
    }

contract Mortal is Ownable {
    function kill() public Owned {
        selfdestruct(owner);
    }
}

contract Bet is Mortal {
    uint minBet;
    uint odds;

    event Won(bool _status, uint _amount);

    function Betting(uint _minBet, uint _odds) payable public {
        require(_minBet > 0);
        minBet = _minBet;
        houseEdge = _houseEdge;

        function() public {
            revert();
        }
    }
}

function bet(uint _number) payable public {
    require(_number > - && _number <= 10);
    require(msg.value >= minBet);
    uint winningNumber = block.number % 10 + 1;

    
}