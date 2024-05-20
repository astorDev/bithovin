import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/key_generators/ec_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';
import 'package:pointycastle/ecc/ecc_fp.dart' as ecc_fp;

class Point {
  BigInt x;
  BigInt y;

  Point(this.x, this.y);

  factory Point.fromECPoint(ECPoint ecPoint) {
    return Point(ecPoint.x!.toBigInteger()!, ecPoint.y!.toBigInteger()!);
  }
}

class Secp256k1 {
  static Secp256k1Instance instance = Secp256k1Instance();

  static Point publicKeyFor(BigInt privateKey) {
    var Q = instance.params.G * privateKey;
    
    return Point.fromECPoint(Q!);
  }

  static BigInt generatePrivateKey() {
    return instance.generatePrivateKey();
  }

  static ECSignature generateSignature(Uint8List rawData, BigInt privateKey, {String algorithmName = 'SHA-256/ECDSA'}) {
    return instance.generateSignature(rawData, privateKey);
  }

  static bool verifySignature(Uint8List signedData, ECSignature signature, Point publicKey, {String algorithm = 'SHA-256/ECDSA'}) {
    return instance.verify(signedData, signature, publicKey);
  }
}

class Secp256k1Instance {
  late ECDomainParameters params;
  late ECKeyGenerator generator;
  late SecureRandom random;

  Secp256k1Instance() {
    params = ECDomainParameters('secp256k1');
    random = getSecureRandom();
  }

  BigInt generatePrivateKey() {
    var n = params.n;
    var nBitLength = n.bitLength;
    BigInt? d;

    do {
      d = random.nextBigInteger(nBitLength);
    } while (d == BigInt.zero || (d >= n));

    return d;
  }

   ECSignature generateSignature(Uint8List rawData, BigInt privateKey, {String algorithmName = 'SHA-256/ECDSA'}) {
    var signer = Signer(algorithmName) as ECDSASigner;
    var privateKeyWithCurve = ECPrivateKey(privateKey, params);
    var signerPrivateKey = PrivateKeyParameter<ECPrivateKey>(privateKeyWithCurve);
    var signerRandom = getSecureRandom();

    var signerParams = ParametersWithRandom(signerPrivateKey, signerRandom);
    signer.init(true, signerParams);

    var sig = signer.generateSignature(rawData) as ECSignature;

    return sig;
  }

  static SecureRandom getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    var seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255 + 1));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  bool verify(Uint8List signedData, ECSignature signature, Point publicKey, {String algorithm = 'SHA-256/ECDSA'}) {
    
    final verifier = Signer(algorithm) as ECDSASigner;

    var pubKey = ECPublicKey(
        ecc_fp.ECPoint(
            params.curve as ecc_fp.ECCurve,
            params.curve.fromBigInteger(publicKey.x) as ecc_fp.ECFieldElement?,
            params.curve.fromBigInteger(publicKey.y) as ecc_fp.ECFieldElement?,
            true),
        params);

    verifier.init(false, PublicKeyParameter<ECPublicKey>(pubKey));

    try {
      return verifier.verifySignature(signedData, signature);
    } on ArgumentError {
      return false;
    }
  }
}