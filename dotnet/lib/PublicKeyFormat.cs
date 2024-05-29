using Bithovin;
using Org.BouncyCastle.Math.EC;

public class PublicKeyPointByteStringFormat<TPublicKey>(
    Func<byte[], string> BytesToString,
    Func<string, byte[]> StringToBytes,
    Func<byte[], ECPoint> BytesToPoint,
    Func<ECPoint, byte[]> PointToBytes,
    Func<TPublicKey, ECPoint> PublicKeyToPoint,
    Func<ECPoint, TPublicKey> PointToPublicKey
)
{
    public string Export(TPublicKey publicKey) => BytesToString(PointToBytes(PublicKeyToPoint(publicKey)));
    public TPublicKey Import(string bytes) => PointToPublicKey(BytesToPoint(StringToBytes(bytes)));
}

public class PublicKeyFormatRegistry
{
    public static PublicKeyPointByteStringFormat<Secp256K1PublicKey> Secp256K1Hex = new(
        BytesToString: Convert.ToHexString,
        StringToBytes: Convert.FromHexString,
        BytesToPoint: Secp256k1.Curve.DecodePoint,
        PointToBytes: point => point.GetEncoded(),
        PublicKeyToPoint: publicKey => publicKey.Point,
        PointToPublicKey: point => new Secp256K1PublicKey(point)
    );
}

