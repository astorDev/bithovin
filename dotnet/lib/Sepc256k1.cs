using Org.BouncyCastle.Asn1.Sec;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Digests;
using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Crypto.Signers;
using Org.BouncyCastle.Math;
using Org.BouncyCastle.Math.EC;
using Org.BouncyCastle.Math.EC.Multiplier;
using Org.BouncyCastle.Security;

namespace Bithovin;

public record BigPoint(
    BigInteger X,
    BigInteger Y
)
{
    public static BigPoint FromECPoint(ECPoint ecPoint) => new(ecPoint.XCoord!.ToBigInteger(), ecPoint.YCoord!.ToBigInteger());
}

public record ECSignature(
    BigInteger r,
    BigInteger s
);


public static class Secp256K1
{
    public static readonly Instance I = new();

    public static BigInteger GeneratePrivateKey() => I.GeneratePrivateKey();
    public static BigPoint PublicKeyFor(BigInteger privateKey) => I.PublicKeyFor(privateKey);
    public static ECSignature GenerateSignature(byte[] rawData, BigInteger privateKey, IDigest? digest = null) => I.GenerateSignature(rawData, privateKey, digest);
    public static bool VerifySignature(byte[] rawData, ECSignature signature, BigPoint publicKey, IDigest? digest = null) => I.VerifySignature(rawData, signature, publicKey, digest);
    
    public class Instance 
    {
        public readonly ECDomainParameters Parameters;

        public Instance()
        {
            var curve = SecNamedCurves.GetByName("secp256k1");
            Parameters = new(curve.Curve, curve.G, curve.N, curve.H);
        }

        public (ECPrivateKeyParameters, ECPublicKeyParameters) GenerateLibKeyPair()
        {
            var secureRandom = new SecureRandom();
            var keyGenParam = new ECKeyGenerationParameters(Parameters, secureRandom);
        
            var keyGen = new ECKeyPairGenerator();
            keyGen.Init(keyGenParam);
        
            var keyPair = keyGen.GenerateKeyPair();
            var privateKey = (ECPrivateKeyParameters)keyPair.Private; 
            var publicKey = (ECPublicKeyParameters)keyPair.Public;
            return (privateKey, publicKey);
        }
        
        public BigInteger GeneratePrivateKey()
        {
            var (privateKey, _) = this.GenerateLibKeyPair();
            return privateKey.D;
        }

        public ECPoint LibPointPublicKeyFor(BigInteger privateKey)
        {
            var multiplier = new FixedPointCombMultiplier();
            var q = multiplier.Multiply(Parameters.G, privateKey);
            return ECAlgorithms.ImportPoint(Parameters.Curve, q).Normalize();
        }

        public BigPoint PublicKeyFor(BigInteger privateKey)
        {
            var libPublicKey = this.LibPointPublicKeyFor(privateKey);
            return BigPoint.FromECPoint(libPublicKey);
        } 
        
        public ECSignature GenerateSignature(byte[] rawData, BigInteger privateKey, IDigest? digest = null)
        {
            digest ??= new Sha256Digest();
            digest.BlockUpdate(rawData, 0, rawData.Length);
            var hash = new byte[digest.GetDigestSize()];
            digest.DoFinal(hash, 0);
            
            var signer = new ECDsaSigner();
            var random = new SecureRandom();
            var privateKeyParameters = new ECPrivateKeyParameters(privateKey, Parameters);
            var signerParameters = new ParametersWithRandom(privateKeyParameters, random);
            signer.Init(forSigning: true, signerParameters);

            var signature = signer.GenerateSignature(hash);

            var r = signature[0];
            var s = signature[1];

            return new(r, s);
        }

        public bool VerifySignature(byte[] rawData, ECSignature signature, BigPoint publicKey, IDigest? digest = null)
        {
            digest ??= new Sha256Digest();
            digest.BlockUpdate(rawData, 0, rawData.Length);
            var hash = new byte[digest.GetDigestSize()];
            digest.DoFinal(hash, 0);
            
            var verifier = new ECDsaSigner();
            var ecPoint = Parameters.Curve.CreatePoint(publicKey.X, publicKey.Y);
            var publicKeyParameters = new ECPublicKeyParameters(ecPoint, Parameters);
            
            verifier.Init(forSigning: false, publicKeyParameters);

            return verifier.VerifySignature(hash, signature.r, signature.s);
        }
    }    
}