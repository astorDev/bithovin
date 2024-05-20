using FluentAssertions;
using Org.BouncyCastle.Math;

namespace Bithovin.Tests;

[TestClass]
public class Secp256k1Should
{
    readonly byte[] Message = "Hello, secp256k1 with C#"u8.ToArray();
    
    [TestMethod]
    public void SignAndVerifyWithNewlyGeneratedKey()
    {
        var privateKey = Secp256K1.GeneratePrivateKey().Printed("privateKey");
        var signature = Secp256K1.GenerateSignature(Message, privateKey).Printed();

        var publicKey = Secp256K1.PublicKeyFor(privateKey).Printed();
        var verified = Secp256K1.VerifySignature(Message, signature, publicKey).Printed("verified");

        verified.Should().BeTrue();
    }

    [TestMethod]
    public void SignAndVerify()
    {
        var privateKey = new BigInteger("23869116530139289825893705285300608498385592429373518138676110202707087592564");
        
        var signature = Secp256K1.GenerateSignature(Message, privateKey).Printed();

        var publicKey = Secp256K1.PublicKeyFor(privateKey).Printed();
        var verified = Secp256K1.VerifySignature(Message, signature, publicKey).Printed("verified");

        verified.Should().BeTrue();
    }
}