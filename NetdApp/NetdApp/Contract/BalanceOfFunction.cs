using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.Contracts;

namespace NetdApp.Contract
{
    [Function("balanceOf", "uint")]
    public class BalanceOfFunction: FunctionMessage
    {
        [Parameter("address", "_owner", 1)]
        public string Who { get; set; }
    }
}