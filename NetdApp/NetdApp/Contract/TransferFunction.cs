using System.Numerics;
using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.Contracts;

namespace NetdApp.Contract
{
    [Function("transfer", "bool")]
    public class TransferFunction: FunctionMessage
    {
        [Parameter("address", "_to", 1)]
        public string To { get; set; }
        
        [Parameter("uint", "_value", 2)]
        public BigInteger Value { get; set; }
    }
}