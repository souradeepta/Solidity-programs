//Rock paper scissors programs using solidity running on Remix
pragma solidity ^ 0.4.13;
contract game
{
    //mapping used to calculate the result
    mapping (string => mapping(string => int)) calculate;
    address player1;
    address player2;
    string public player1Hand;
    string public player2Hand;
    
    // constructor which sets the hands and the winner
    function game() 
    {   
        calculate["rock"]["rock"] = 0;
        calculate["rock"]["paper"] = 2;
        calculate["rock"]["scissors"] = 1;
        calculate["paper"]["rock"] = 1;
        calculate["paper"]["paper"] = 0;
        calculate["paper"]["scissors"] = 2;
        calculate["scissors"]["rock"] = 2;
        calculate["scissors"]["paper"] = 1;
        calculate["scissors"]["scissors"] = 0;
    }
    
    //note pressing this button on remix wont work because just before it returns the values it also resets the hands
    function getWinner() constant returns (int x)
    {   
        if (bytes(player1Hand).length != 0 && bytes(player2Hand).length != 0)
        {
            int winner = calculate[player1Hand][player2Hand];
            if (winner == 1)
                player1.transfer(this.balance);
            else if (winner == 2)
                player2.transfer(this.balance);
            else
            {
                player1.transfer(this.balance/2);
                player2.transfer(this.balance);
            }
             
            // unregister players and choices
            player1Hand = "";
            player2Hand = "";
            player1 = 0;
            player2 = 0;
            return winner;
        }
        else 
            return -1;
        //return calculate[player1Choice][player2Choice];
    }
    
    //Check if both players have been registered yet
    modifier notRegistered()
    {
        if (msg.sender == player1 || msg.sender == player2)
            revert();
         else
            _
    ;}
    
    //checks if cash values is greater than our minimum amount
    modifier sentCash(uint minAmount)
    {
        if (msg.value < minAmount)
           revert();
        else
            _
    ;}
    
    //call which checks if the players are registered
    function register () public payable
        sentCash(5)
        notRegistered()
    {
        if (player1 == 0)
            player1 = msg.sender;
        else if (player2 == 0)
            player2 = msg.sender;
    }
    
    //press this button to add our hand of player
    function play(string hand) public payable returns (int w)
    {
        if (msg.sender == player1)
        {
            player1Hand = hand;
         //   compareStrings(choice, " ");
        }
        else if (msg.sender == player2)
        {
            player2Hand = hand;

        }
        int result = getWinner();
        return result;
    }
    
    

    //check balance of currnt player's account to know how much it has lost or won
    function getMyBalance () constant returns (uint amount)
    {
        return msg.sender.balance;
    }
    
    //check how much balance the contract has. Once the game is finished the winner gets it all and the balance is zero
    function getContractBalance () constant returns (uint amount)
    {
        return this.balance;
    }
    
    //check which players instance is sending the messages
    function IsPlayer1() constant returns (bool x)
    {
        return msg.sender == player1;
    }
    
    function IsPlayer2() constant returns (bool x)
    {
        return msg.sender == player2;
    }

}