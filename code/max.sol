//Find maximum program on solidity running on Remix
pragma solidity ^ 0.4.13;

    contract maximum{
        int x;
        int y;
        function input( int a, int b) public {
            x=a;
            y=b;
        }
        
        function max() public constant returns(int) {
            if(x>y)
            return x;
            else 
            return y;
        }
    }