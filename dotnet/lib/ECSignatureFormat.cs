namespace Bithovin;

public class ECSignatureBytesStringFormat(
    Func<byte[], string> BytesToString,
    Func<string, byte[]> StringToBytes,
    Func<byte[], ECSignature> BytesToSignature,
    Func<ECSignature, byte[]> SignatureToBytes
) : ECSignatureStringFormat
{
    public string Export(ECSignature signature) => BytesToString(SignatureToBytes(signature));
    public ECSignature Import(string bytes) => BytesToSignature(StringToBytes(bytes));
}

public interface ECSignatureStringFormat
{
    string Export(ECSignature signature);
    ECSignature Import(string bytes);
}

public static class ECSignatureFormatRegistry
{
    public static ECSignatureStringFormat Sec1DerHex = new ECSignatureBytesStringFormat(
        BytesToString: Convert.ToHexString,
        StringToBytes: Convert.FromHexString,
        BytesToSignature: Sec1Der.DecodeECSignature,
        SignatureToBytes: Sec1Der.Encode
    );
}
