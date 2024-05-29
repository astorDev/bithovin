using Org.BouncyCastle.Math;

namespace Bithovin;

public record ECSignature(
    BigInteger r,
    BigInteger s
);
