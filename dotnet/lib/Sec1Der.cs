using Bithovin;
using Org.BouncyCastle.Asn1;

public class Sec1Der
{
    public static ECSignature Parse(byte[] bytes) {
        MemoryStream signatureStream = new MemoryStream(bytes);
        DerSequence derSequence = (DerSequence)Asn1Object.FromStream(signatureStream);
        var r = (DerInteger)derSequence[0];
        var s = (DerInteger)derSequence[1];

        return new ECSignature(r.Value, s.Value);
    }
}