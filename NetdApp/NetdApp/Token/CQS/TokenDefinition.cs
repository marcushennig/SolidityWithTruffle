using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Numerics;
using Nethereum.Hex.HexTypes;
using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.Web3;
using Nethereum.RPC.Eth.DTOs;
using Nethereum.Contracts.CQS;
using Nethereum.Contracts;
using System.Threading;

namespace NetdApp.Token.CQS
{


    public partial class TokenDeployment : TokenDeploymentBase
    {
        public TokenDeployment() : base(BYTECODE) { }
        public TokenDeployment(string byteCode) : base(byteCode) { }
    }

    public class TokenDeploymentBase : ContractDeploymentMessage
    {
        public static string BYTECODE = "60806040526040805190810160405280600b81526020017f455243323020546f6b656e0000000000000000000000000000000000000000008152506000908051906020019061004f9291906100fa565b506040805190810160405280600381526020017f544f4b00000000000000000000000000000000000000000000000000000000008152506001908051906020019061009b9291906100fa565b5060126002553480156100ad57600080fd5b50620186a0600460003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000208190555061019f565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061013b57805160ff1916838001178555610169565b82800160010185558215610169579182015b8281111561016857825182559160200191906001019061014d565b5b509050610176919061017a565b5090565b61019c91905b80821115610198576000816000905550600101610180565b5090565b90565b610629806101ae6000396000f3fe608060405234801561001057600080fd5b506004361061009a576000357c01000000000000000000000000000000000000000000000000000000009004806370a082311161007857806370a082311461019857806376809ce3146101f057806395d89b411461020e578063a9059cbb146102915761009a565b806306fdde031461009f57806318160ddd1461012257806327e235e314610140575b600080fd5b6100a76102f7565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100e75780820151818401526020810190506100cc565b50505050905090810190601f1680156101145780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b61012a610395565b6040518082815260200191505060405180910390f35b6101826004803603602081101561015657600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919050505061039b565b6040518082815260200191505060405180910390f35b6101da600480360360208110156101ae57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506103b3565b6040518082815260200191505060405180910390f35b6101f86103fc565b6040518082815260200191505060405180910390f35b610216610402565b6040518080602001828103825283818151815260200191508051906020019080838360005b8381101561025657808201518184015260208101905061023b565b50505050905090810190601f1680156102835780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b6102dd600480360360408110156102a757600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190803590602001909291905050506104a0565b604051808215151515815260200191505060405180910390f35b60008054600181600116156101000203166002900480601f01602080910402602001604051908101604052809291908181526020018280546001816001161561010002031660029004801561038d5780601f106103625761010080835404028352916020019161038d565b820191906000526020600020905b81548152906001019060200180831161037057829003601f168201915b505050505081565b60035481565b60046020528060005260406000206000915090505481565b6000600460008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549050919050565b60025481565b60018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156104985780601f1061046d57610100808354040283529160200191610498565b820191906000526020600020905b81548152906001019060200180831161047b57829003601f168201915b505050505081565b600081600460003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205410151515610559576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004018080602001828103825260128152602001807f496e73756666696369656e742066756e6473000000000000000000000000000081525060200191505060405180910390fd5b81600460003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000828254039250508190555081600460008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282540192505081905550600190509291505056fea165627a7a72305820cd3c51845ad4e4e3fa379d855b55075b406b6defee65683ac66fafa190fc65c20029";
        public TokenDeploymentBase() : base(BYTECODE) { }
        public TokenDeploymentBase(string byteCode) : base(byteCode) { }

    }

    public partial class NameFunction : NameFunctionBase { }

    [Function("name", "string")]
    public class NameFunctionBase : FunctionMessage
    {

    }

    public partial class TotalSupplyFunction : TotalSupplyFunctionBase { }

    [Function("totalSupply", "uint256")]
    public class TotalSupplyFunctionBase : FunctionMessage
    {

    }

    public partial class BalancesFunction : BalancesFunctionBase { }

    [Function("balances", "uint256")]
    public class BalancesFunctionBase : FunctionMessage
    {
        [Parameter("address", "", 1)]
        public virtual string ReturnValue1 { get; set; }
    }

    public partial class BalanceOfFunction : BalanceOfFunctionBase { }

    [Function("balanceOf", "uint256")]
    public class BalanceOfFunctionBase : FunctionMessage
    {
        [Parameter("address", "_owner", 1)]
        public virtual string Owner { get; set; }
    }

    public partial class DecimalFunction : DecimalFunctionBase { }

    [Function("decimal", "uint256")]
    public class DecimalFunctionBase : FunctionMessage
    {

    }

    public partial class SymbolFunction : SymbolFunctionBase { }

    [Function("symbol", "string")]
    public class SymbolFunctionBase : FunctionMessage
    {

    }

    public partial class TransferFunction : TransferFunctionBase { }

    [Function("transfer", "bool")]
    public class TransferFunctionBase : FunctionMessage
    {
        [Parameter("address", "_to", 1)]
        public virtual string To { get; set; }
        [Parameter("uint256", "_value", 2)]
        public virtual BigInteger Value { get; set; }
    }

    public partial class NameOutputDTO : NameOutputDTOBase { }

    [FunctionOutput]
    public class NameOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("string", "", 1)]
        public virtual string ReturnValue1 { get; set; }
    }

    public partial class TotalSupplyOutputDTO : TotalSupplyOutputDTOBase { }

    [FunctionOutput]
    public class TotalSupplyOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("uint256", "", 1)]
        public virtual BigInteger ReturnValue1 { get; set; }
    }

    public partial class BalancesOutputDTO : BalancesOutputDTOBase { }

    [FunctionOutput]
    public class BalancesOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("uint256", "", 1)]
        public virtual BigInteger ReturnValue1 { get; set; }
    }

    public partial class BalanceOfOutputDTO : BalanceOfOutputDTOBase { }

    [FunctionOutput]
    public class BalanceOfOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("uint256", "", 1)]
        public virtual BigInteger ReturnValue1 { get; set; }
    }

    public partial class DecimalOutputDTO : DecimalOutputDTOBase { }

    [FunctionOutput]
    public class DecimalOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("uint256", "", 1)]
        public virtual BigInteger ReturnValue1 { get; set; }
    }

    public partial class SymbolOutputDTO : SymbolOutputDTOBase { }

    [FunctionOutput]
    public class SymbolOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("string", "", 1)]
        public virtual string ReturnValue1 { get; set; }
    }


}
