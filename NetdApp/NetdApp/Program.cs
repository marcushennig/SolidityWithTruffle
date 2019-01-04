using System;
using Nethereum.HdWallet;
using System.Numerics;
using System.Threading.Tasks;
using NetdApp.Token.Service;
using Nethereum.Web3;

namespace NetdApp
{
    static class Program
    {
        #region Parameters
        
        /// <summary>
        /// HD-Path used in Ganache
        /// </summary>
        private const string HdPath  ="m/44'/60'/0'/0/x";
        
        /// <summary>
        /// mnemonic from Ganache
        /// </summary>
        private const string Mnemonic =
            "monitor flight amateur civil give gauge wing deal fragile enforce hope virtual";
        /// <summary>
        /// Wallet holding all private keys
        /// </summary>
        private static readonly Wallet Wallet = new Wallet(Mnemonic, null, HdPath);

        /// <summary>
         /// Ganache RPC-server URL
         /// </summary>
        private const string Url = "http://127.0.0.1:7545";

        const string ContractAddress = "0xa145f71FDD869dBc59905Ff73186c7824ae34fB6";

        #endregion Parameters
        
        #region Methods
        
        /// <summary>
        /// Test Web3 interface
        /// </summary>
        /// <returns></returns>
        private static async Task TestBalance()
        {
            var web3 = new Web3(Url);
            for (var i = 0; i < 10; i++)
            {
                var account = Wallet.GetAccount(i);
                var balance = await web3.Eth.GetBalance.SendRequestAsync(account.Address);

                Console.WriteLine($"{account}: {Web3.Convert.FromWei(balance)} ETH");     
            }
        }
        
        #endregion Methods

        private static async Task TestTokenService()
        {
            var account = Wallet.GetAccount(0);
            var web3 = new Web3(account, Url);
            var token = new TokenService(web3, ContractAddress);
            
            var symbol = await token.SymbolQueryAsync();
            Console.WriteLine(symbol);
        }

        static async Task Main(string[] args)
        {
            await TestTokenService();
        }
    }
}