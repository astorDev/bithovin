using FluentAssertions;

namespace Bithovin.Tests;

[TestClass]
public class Secp256k1Should
{
    readonly byte[] Message = "Hello, secp256k1 with C#"u8.ToArray();
    
    [TestMethod]
    public void SignAndVerifyWithNewlyGeneratedKey()
    {
        var privateKey = Secp256K1PrivateKey.Generate().Printed("privateKey");
        var signature = privateKey.GenerateSignature(Message).Printed();

        var publicKey = privateKey.GetPublicKey().Printed("publicKey");
        var verificationResult = publicKey.VerifySignature(Message, signature).Printed("verified");

        verificationResult.Valid.Should().BeTrue();
    }

    [TestMethod]
    public void VerifyFromOutside()
    {
        var publicKey = Secp256K1PublicKey.FromBigIntegers(
          new ("21285371770960987179343891334477951184299084915952205959541518459254283849951"),
          new ("22671947423549970796294697518695530648245966458430018258533359741779880876856")
        );

        var signature = new ECSignature(
          new ("86058557054575571086167585107837415358165949453073739311202780092611888743858"),
          new ("22076606289889717131594195825238606622326255596425005294818774860206769341915")
        );

        var message = "Hello from dart secp256k1!"u8.ToArray();

        var verificationResult = publicKey.VerifySignature(message, signature).Printed("verified");
        verificationResult.Valid.Should().BeTrue();
    }

    [TestMethod]
    public void VerifyStringRepresentationsFromOutside()
    {
        var publicKeyImport = "021371f38c3e1a5be327b1d9b2f81ebe1d990e0328f247246bba0a35a04e8e52e4";
        var signatureImport = "304402204fa25cf90189e5ae7b2d2256e189e708a16e55abedb1182585dda38bdd468bcf02205b259c619c8dca76106f6e160f0ee36b27e5abbc7c606f282aae73aad088f0d8";

        var publicKey = Secp256K1PublicKey.Decode(Convert.FromHexString(publicKeyImport)).Printed("publicKey");
        var signature = Sec1Der.Parse(Convert.FromHexString(signatureImport)).Printed("signature");
        
        var verification = publicKey.VerifySignature(Message, signature).Printed("verified");
        verification.Valid.Should().BeTrue();
    }

    [TestMethod]
    public void VerifyFromJavascript()
    {
        var message = "{ 'hey' : 'you' }"u8;
        var importedPublicKey = "04df394d77ee3b401e8ebe666bb5bec51aa3f714a03977c82b61879265a17ea83b6fcecbbcc200341a0e55b9ffac5ee71ea521e47bbbfe8d9a073f0691b9161fba";
        var importedSignature = "304402206db1e59a246c86c8c6f78101561362e98c3fa821653c72b69c8c6fd4efcf428502203f52f3ad842ec29c1daba409f9375e615d6d189f924ac51dd48b83649f29a7e2";

        var publicKey = Secp256K1PublicKey.Decode(Convert.FromHexString(importedPublicKey)).Printed("publicKey");
        var signature = Sec1Der.Parse(Convert.FromHexString(importedSignature)).Printed("signature");

        var verification = publicKey.VerifySignature(message, signature).Printed("verified");
        verification.Valid.Should().BeTrue();
    }
}