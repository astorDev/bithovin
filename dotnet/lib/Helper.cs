using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Digests;
using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Math;
using Org.BouncyCastle.Math.EC;
using Org.BouncyCastle.Math.EC.Multiplier;
using Org.BouncyCastle.Security;

namespace Bithovin;

public static class Helper
{
    public static ECPoint PublicKeyFor(BigInteger privateKey, ECDomainParameters parameters)
    {
        var multiplier = new FixedPointCombMultiplier();
        var q = multiplier.Multiply(parameters.G, privateKey);
        return ECAlgorithms.ImportPoint(parameters.Curve, q).Normalize();
    }

    public static byte[] CreateHash(this IDigest? digest, byte[] rawData)
    {
        digest ??= new Sha256Digest();
        digest.BlockUpdate(rawData, 0, rawData.Length);
        var hash = new byte[digest.GetDigestSize()];
        digest.DoFinal(hash, 0);
        return hash;
    }

    public static (ECPrivateKeyParameters, ECPublicKeyParameters) GenerateKeyPair(ECDomainParameters parameters)
    {
        var secureRandom = new SecureRandom();
        var keyGenParam = new ECKeyGenerationParameters(parameters, secureRandom);

        var keyGen = new ECKeyPairGenerator();
        keyGen.Init(keyGenParam);

        var keyPair = keyGen.GenerateKeyPair();
        var privateKey = (ECPrivateKeyParameters)keyPair.Private;
        var publicKey = (ECPublicKeyParameters)keyPair.Public;
        return (privateKey, publicKey);
    }
}
