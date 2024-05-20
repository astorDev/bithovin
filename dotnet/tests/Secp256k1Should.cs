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
        var verificationResult = Secp256K1.VerifySignature(Message, signature, publicKey).Printed("verified");

        verificationResult.Valid.Should().BeTrue();
    }

    [TestMethod]
    public void SignAndVerify()
    {
        var privateKey = new BigInteger("23869116530139289825893705285300608498385592429373518138676110202707087592564");
        
        var signature = Secp256K1.GenerateSignature(Message, privateKey).Printed();

        var publicKey = Secp256K1.PublicKeyFor(privateKey).Printed();
        var verificationResult = Secp256K1.VerifySignature(Message, signature, publicKey).Printed("verified");

        verificationResult.Valid.Should().BeTrue();
    }

    [TestMethod]
    public void VerifyFromOutside()
    {
        var publicKey = new BigPoint(
          new ("21285371770960987179343891334477951184299084915952205959541518459254283849951"),
          new ("22671947423549970796294697518695530648245966458430018258533359741779880876856")
        );

        var signature = new ECSignature(
          new ("86058557054575571086167585107837415358165949453073739311202780092611888743858"),
          new ("22076606289889717131594195825238606622326255596425005294818774860206769341915")
        );

        var message = "Hello from dart secp256k1!"u8.ToArray();

        var verificationResult = Secp256K1.VerifySignature(message, signature, publicKey).Printed("verified");
        verificationResult.Valid.Should().BeTrue();
    }

    [TestMethod]
    public void VerifyInvalidFromOutside()
    {
        var publicKey = new BigPoint(
          new ("21285371770960987179343891334477951184299084915952205959541518459254283849952"), //invalidly ends with 2
          new ("22671947423549970796294697518695530648245966458430018258533359741779880876856")
        );

        var signature = new ECSignature(
          new ("86058557054575571086167585107837415358165949453073739311202780092611888743858"),
          new ("22076606289889717131594195825238606622326255596425005294818774860206769341915")
        );

        var message = "Hello from dart secp256k1!"u8.ToArray();

        var verificationResult = Secp256K1.VerifySignature(message, signature, publicKey).Printed("verified");
        verificationResult.Valid.Should().BeTrue();
    }
}