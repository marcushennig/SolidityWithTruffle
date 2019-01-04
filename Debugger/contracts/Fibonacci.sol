pragma solidity ^0.5.0;


contract Fibonacci {
    
    uint[] public fibonacciSeries;

    /**
    @dev Generate fibonacci series of n numbers
    @param n number of integers in the sequence to generate
     */
    function generate(uint n) 
    public {

        fibonacciSeries.push(1);
        fibonacciSeries.push(1);

        for (uint i = 2; i < n; i++) {

            fibonacciSeries.push(fibonacciSeries[i-1] + fibonacciSeries[i-2]);
        }
    }
}