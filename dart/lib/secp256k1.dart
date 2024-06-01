import 'dart:typed_data';
import 'package:bithovin/elliptic_curve.dart';
import 'package:bithovin/secure_randoms.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

class Secp256k1 {
  static ECCurve get curve => params.curve;
  static ECDomainParameters params = ECDomainParameters('secp256k1');
}

class Secp256k1PrivateKey {
  ECPrivateKey value;

  Secp256k1PrivateKey.unsafe(this.value);

  factory Secp256k1PrivateKey.unsafeFromBigInt(BigInt d) {
    var privateKey = ECPrivateKey(d, Secp256k1.params);
    return Secp256k1PrivateKey.unsafe(privateKey);
  }

  Secp256k1PublicKey getPublicKey() {
    var Q = value.parameters!.G * value.d!;
    var pubKey = ECPublicKey(Q, value.parameters);
    return Secp256k1PublicKey.unsafe(pubKey);
  }

  factory Secp256k1PrivateKey.generateNew() {
    var privateKey = SecureRandoms.fortunaSeededWithDartSecureRandom().generateECPrivateKey(Secp256k1.params);
    return Secp256k1PrivateKey.unsafe(privateKey);
  }

  ECSignature sign(Uint8List data, {String algorithm = 'SHA-256/ECDSA'}) => EllipticCurve.sign(data, value, algorithm);

  @override
  String toString() => value.d.toString();

  @override
  bool operator ==(Object other) {
    if (other is Secp256k1PrivateKey) {
      return value.d == other.value.d;
    }
    return false;
  }
  
  @override
  int get hashCode => value.hashCode;
}

class Secp256k1PublicKey {
  ECPublicKey value;
  ECPoint get Q => value.Q!;

  Secp256k1PublicKey.unsafe(this.value);

  factory Secp256k1PublicKey.fromPoint(ECPoint point) {
    var pubKey = ECPublicKey(point, Secp256k1.params);
    return Secp256k1PublicKey.unsafe(pubKey);
  }

  factory Secp256k1PublicKey.fromRawBigIntegers(BigInt x, BigInt y) {
    var pubKey = EllipticCurve.constructPublicKey(x, y, Secp256k1.params);
    return Secp256k1PublicKey.unsafe(pubKey);
  }

  bool verify(Uint8List data, ECSignature signature, {String algorithm = 'SHA-256/ECDSA'}) {
    final verifier = Signer(algorithm) as ECDSASigner;

    verifier.init(false, PublicKeyParameter<ECPublicKey>(value));

    try {
      return verifier.verifySignature(data, signature);
    } on ArgumentError {
      return false;
    }
  }

  @override
  String toString() => '${value.Q!}';

  @override 
  bool operator ==(Object other) {
    if (other is Secp256k1PublicKey) {
      return value.Q == other.value.Q;
    }
    return false;
  }
  
  @override
  int get hashCode => value.Q!.hashCode;
}