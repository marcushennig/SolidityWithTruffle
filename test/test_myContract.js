const MyContract = artifacts.require("MyContract");

contract("1st MyContract test", async accounts => {
    
    it("Should correctly compute the area of an rectangle", async () => {

        let instance = await MyContract.deployed();
        let w = 2;
        let h = 4;
        let result = await instance.rectangle(w, h);

        assert.equal(result[0], w * h);
  });

  it("Should correctly compute the area of an rectangle", async () => {
      
        let instance = await MyContract.deployed();
        let w = 200;
        let h = 400;
        let result = await instance.rectangle(w, h);

        assert.equal(result[0], w * h);
    });
});