const Fibonacci = artifacts.require("Fibonacci");

contract("Fibonacci tests", async accounts => {
    

    it("Correct fibonacci series", async () => {

        let fibonacci = await Fibonacci.deployed();

        let result = await fibonacci.generate(10);
        let x = await fibonacci.fibonacciSeries(1);

        assert.equal(1, x);
    }); 
});
    