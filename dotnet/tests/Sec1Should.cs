using FluentAssertions;

namespace Bithovin.Tests;

[TestClass]
public class Sec1Should 
{
    [TestMethod]
    public void EncodeAndDecodeECSignatures()
    {
        var source = new ECSignature(
            new ("86058557054575571086167585107837415358165949453073739311202780092611888743858"),
            new ("22076606289889717131594195825238606622326255596425005294818774860206769341915")
        );

        var encoded = source.EncodedUsingSec1Der();
        var decoded = encoded.DecodedToECSignatureUsingSec1Der();

        decoded.Should().BeEquivalentTo(source);
    }
}