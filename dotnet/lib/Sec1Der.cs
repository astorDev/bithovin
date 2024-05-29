using Bithovin;
using Org.BouncyCastle.Asn1;

public class Sec1Der
{
    public static byte[] Encode(ECSignature signature) {
        var derSequence = new DerSequence(
            new DerInteger(signature.r),
            new DerInteger(signature.s)
        );

        return derSequence.GetDerEncoded();
    }


    public static ECSignature DecodeECSignature(byte[] bytes) {
        using var signatureStream = new MemoryStream(bytes);
        var derSequence = (DerSequence)Asn1Object.FromStream(signatureStream);
        var r = (DerInteger)derSequence[0];
        var s = (DerInteger)derSequence[1];

        return new ECSignature(r.Value, s.Value);
    }
}

public static class Sec1Extensions
{
    public static byte[] EncodedUsingSec1Der(this ECSignature signature) {
        return Sec1Der.Encode(signature);
    }

    public static ECSignature DecodedToECSignatureUsingSec1Der(this byte[] bytes) {
        return Sec1Der.DecodeECSignature(bytes);
    }
}