import 'dart:typed_data';

import 'package:bithovin/secure_randoms.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';
import 'package:pointycastle/ecc/ecc_fp.dart' as ecc_fp;

class EllipticCurve {
  static ECSignature sign(Uint8List data,  ECPrivateKey value, String algorithm) {
    var signer = Signer(algorithm) as ECDSASigner;
    var signerPrivateKey = PrivateKeyParameter<ECPrivateKey>(value);
    var signerRandom = SecureRandoms.fortunaSeededWithDartSecureRandom();
    var signerParams = ParametersWithRandom(signerPrivateKey, signerRandom);
    signer.init(true, signerParams);

    return signer.generateSignature(data) as ECSignature;
  }

  static ECPublicKey constructPublicKey(BigInt x, BigInt y, ECDomainParameters params) {
    var Q = ecc_fp.ECPoint(
      params.curve as ecc_fp.ECCurve,
      params.curve.fromBigInteger(x) as ecc_fp.ECFieldElement?,
      params.curve.fromBigInteger(y) as ecc_fp.ECFieldElement?,
      true
    );

    return ECPublicKey(Q, params);
  }

  static bool verify(Uint8List data, ECSignature signature, ECPublicKey publicKey, {String algorithm = 'SHA-256/ECDSA'}) {
    final verifier = Signer(algorithm) as ECDSASigner;

    verifier.init(false, PublicKeyParameter<ECPublicKey>(publicKey));

    try {
      return verifier.verifySignature(data, signature);
    } on ArgumentError {
      return false;
    }
  }
}