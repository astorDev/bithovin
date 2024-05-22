import 'dart:typed_data';
import 'package:dart/sec_compressed.dart';
import 'package:dart/utils.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

class Secp256k1 {
  static ECCurve get curve => params.curve;
  static ECDomainParameters params = ECDomainParameters('secp256k1');
}

class Secp256k1PrivateKey {
  ECPrivateKey value;

  Secp256k1PrivateKey._internal(this.value);

  Secp256k1PublicKey getPublicKey() {
    var Q = value.parameters!.G * value.d!;
    var pubKey = ECPublicKey(Q, value.parameters);
    return Secp256k1PublicKey._internal(pubKey);
  }

  factory Secp256k1PrivateKey.generateNew() {
    var privateKey = SecureRandoms.fortunaSeededWithDartSecureRandom().generatePrivateKey(Secp256k1.params);
    return Secp256k1PrivateKey._internal(privateKey);
  }

  ECSignature sign(Uint8List data, {String algorithm = 'SHA-256/ECDSA'}) => EllipticCurve.sign(data, value, algorithm);

  @override
  String toString() => value.d.toString();
}

class Secp256k1PublicKey {
  ECPublicKey value;

  Secp256k1PublicKey._internal(this.value);

  factory Secp256k1PublicKey.fromRawBigIntegers(BigInt x, BigInt y) {
    var pubKey = EllipticCurve.constructPublicKey(x, y, Secp256k1.params);
    return Secp256k1PublicKey._internal(pubKey);
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

  SecCompressed toSecCompressed() {
    return SecCompressed.fromECPoint(value.Q!);
  }
}

extension SecCompressedExtensions on SecCompressed {
  Secp256k1PublicKey toSecp256k1PublicKey() {
    var Q = toECPoint(Secp256k1.curve);
    var pubKey = ECPublicKey(Q, Secp256k1.params);
    return Secp256k1PublicKey._internal(pubKey);
  }
}