using FluentAssertions;

namespace Bithovin.Tests;

[TestClass]
public class FormatsShould 
{
    [TestMethod]
    public void ExportAndImportSec1DerHex()
    {
        var source = new ECSignature(
            new ("86058557054575571086167585107837415358165949453073739311202780092611888743858"),
            new ("22076606289889717131594195825238606622326255596425005294818774860206769341915")
        );

        var format = ECSignatureFormatRegistry.Sec1DerHex;

        var exported = format.Export(source).Printed("exported");
        var imported = format.Import(exported).Printed("imported");

        imported.Should().BeEquivalentTo(source);
    }

    [TestMethod]
    public void ExportAndImportSec256k1PublicKey()
    {
        var source = Secp256K1PrivateKey.Generate().GetPublicKey();

        var format = PublicKeyFormatRegistry.Secp256K1Hex;

        var exported = format.Export(source).Printed("exported");
        var imported = format.Import(exported).Printed("imported");

        imported.Should().BeEquivalentTo(source);
    }
}