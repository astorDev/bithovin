using Org.BouncyCastle.Asn1.Sec;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Digests;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Crypto.Signers;
using Org.BouncyCastle.Math;
using Org.BouncyCastle.Math.EC;
using Org.BouncyCastle.Security;

namespace Bithovin;

public class Secp256k1
{
    public static ECCurve Curve => parameters.Curve;
    public static readonly ECDomainParameters parameters = Construct();

    public static ECDomainParameters Construct()
    {
        var curve = SecNamedCurves.GetByName("secp256k1");
        return new(curve.Curve, curve.G, curve.N, curve.H);
    }
}

public record Secp256K1PrivateKey(ECPrivateKeyParameters Value)
{
    public static Secp256K1PrivateKey Generate()
    {
        var (privateKey, _) = Helper.GenerateKeyPair(Secp256k1.parameters);
        return new Secp256K1PrivateKey(privateKey);
    }

    public Secp256K1PublicKey GetPublicKey()
    {
        var publicKey = Helper.PublicKeyFor(Value.D, Secp256k1.parameters);
        return new Secp256K1PublicKey(publicKey);
    }

    public ECSignature GenerateSignature(byte[] rawData, IDigest? digest = null)
    {
        var hash = digest.CreateHash(rawData);

        var signer = new ECDsaSigner();
        var random = new SecureRandom();
        var signerParameters = new ParametersWithRandom(Value, random);
        signer.Init(forSigning: true, signerParameters);

        var signature = signer.GenerateSignature(hash);

        var r = signature[0];
        var s = signature[1];

        return new(r, s);
    }
}

public record Secp256K1PublicKey(ECPoint Point)
{
    public static Secp256K1PublicKey Decode(byte[] bytes)
    {
        var ecPoint = Secp256k1.Curve.DecodePoint(bytes);
        return new(ecPoint);
    }

    public static Secp256K1PublicKey FromBigIntegers(BigInteger x, BigInteger y)
    {
        var ecPoint = Secp256k1.Curve.CreatePoint(x, y);
        return new(ecPoint);
    }

    public VerificationResult VerifySignature(byte[] rawData, ECSignature signature, IDigest? digest = null)
    {
        digest ??= new Sha256Digest();
        digest.BlockUpdate(rawData, 0, rawData.Length);
        var hash = new byte[digest.GetDigestSize()];
        digest.DoFinal(hash, 0);

        var verifier = new ECDsaSigner();

        return VerificationResult.From(() =>
        {
            var publicKeyParameters = new ECPublicKeyParameters(Point, Secp256k1.parameters);
            verifier.Init(forSigning: false, publicKeyParameters);
            return verifier.VerifySignature(hash, signature.r, signature.s);
        });
    }

    public VerificationResult VerifySignature(ReadOnlySpan<byte> rawData, ECSignature signature, IDigest? digest = null)
    {
        return VerifySignature(rawData.ToArray(), signature, digest);
    }
}