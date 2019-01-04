using System.Threading.Tasks;
using NetdApp.Contract;
using Nethereum.HdWallet;
using Nethereum.Web3;
using Xunit;

namespace UnitTestToken
{
    public class UnitTestTokenContract
    {
        #region Parameters
        
        /// <summary>
        /// HD-Path used in Ganache
        /// </summary>
        private const string HdPath  ="m/44'/60'/0'/0/x";
        
        /// <summary>
        /// mnemonic from Ganache
        /// </summary>
        private const string Mnemonic = "monitor flight amateur civil give gauge wing deal fragile enforce hope virtual";
        /// <summary>
        /// Wallet holding all private keys
        /// </summary>
        private static readonly Wallet Wallet = new Wallet(Mnemonic, null, HdPath);

        /// <summary>
        /// Ganache RPC-server URL
        /// </summary>
        private const string Url = "http://127.0.0.1:7545";
        
        /// <summary>
        /// Copy from console
        /// </summary>
        const string ContractAddress = "0xa145f71FDD869dBc59905Ff73186c7824ae34fB6";

        #endregion Parameters
        
        [Fact]
        public async Task TestTokenTransfer()
        {
            var account = Wallet.GetAccount(0);
            var web3 = new Web3(account, Url);

            var receiverAddress = Wallet.GetAccount(1).Address;
            var transferHandler = web3.Eth.GetContractTransactionHandler<TransferFunction>();
            var transfer = new TransferFunction
            {
                To = receiverAddress,
                Value = 1
            };
            var transactionReceipt = await transferHandler.SendRequestAndWaitForReceiptAsync(ContractAddress, transfer);
        }
    }
}