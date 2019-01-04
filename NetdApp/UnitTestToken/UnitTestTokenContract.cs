using System.Threading.Tasks;
using Xunit;

namespace UnitTestToken
{
    public class UnitTestTokenContract: IClassFixture<TokenFixture>
    {
        private readonly TokenFixture _fixture;
        
        public UnitTestTokenContract(TokenFixture tokenFixture)
        {
            _fixture = tokenFixture;
        }

        [Fact]
        public async Task TestSymbolAndName()
        {
            var token = _fixture.Token;
            
            var symbol = await token.SymbolQueryAsync();
            var name = await token.NameQueryAsync();
            
            Assert.Equal("TOK", symbol);
            Assert.Equal("ERC20 Token",  name);
        }

        [Fact]
        public async Task TestTokenTransfer()
        {
            var wallet = _fixture.Wallet;
            var token = _fixture.Token;

            var transferredAmount = 1000;
            var sender = wallet.GetAccount(0).Address;
            var receiver = wallet.GetAccount(1).Address;

            var initialBalanceSender = await token.BalanceOfQueryAsync(sender);
            var initialBalanceReceiver = await token.BalanceOfQueryAsync(receiver);

            var receipt = await token.TransferRequestAndWaitForReceiptAsync(receiver, transferredAmount);
            
            Assert.NotNull(receipt);
            
            var finalBalanceSender = await token.BalanceOfQueryAsync(sender);
            var finalBalanceReceiver = await token.BalanceOfQueryAsync(receiver);

            Assert.Equal(transferredAmount, finalBalanceReceiver - initialBalanceReceiver);
            Assert.True(initialBalanceSender - finalBalanceSender >= transferredAmount);
        }
    }
}