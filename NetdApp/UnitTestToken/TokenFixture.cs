using System;
using NetdApp.Token.Service;
using Nethereum.HdWallet;
using Nethereum.Web3;

namespace UnitTestToken
{
    public class TokenFixture: IDisposable
    {
        #region Properties

        /// <summary>
        /// Wallet holding all private keys
        /// </summary>
        public Wallet Wallet { get; }

        /// <summary>
        /// C#-wrapper for token
        /// </summary>
        public TokenService Token { get; }

        #endregion Properties
        
        #region Constructor 
        
        public TokenFixture()
        {
            // HD-Path used in Ganache
            const string hdPath  ="m/44'/60'/0'/0/x";
            // mnemonic from Ganache
            const string mnemonic = "monitor flight amateur civil give gauge wing deal fragile enforce hope virtual";
            
            const string url = "http://127.0.0.1:7545";
            const string contractAddress = "0xa145f71FDD869dBc59905Ff73186c7824ae34fB6";

            Wallet = new Wallet(mnemonic, null, hdPath);
            
            var account = Wallet.GetAccount(0);
            var web3 = new Web3(account, url);
            
            Token = new TokenService(web3, contractAddress);
        }

        #endregion
        
        #region Methods
        
        public void Dispose()
        {
            // clean up test data from the database
        }
        
        #endregion
    }
}