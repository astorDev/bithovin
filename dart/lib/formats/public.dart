import 'dart:typed_data';

import 'hex.dart';
import '../secp256k1.dart';
import 'package:pointycastle/ecc/api.dart';

class PublicKeyPointByteStringFormat<TPublicKey> {
  final String Function(Uint8List) bytesToString;
  final Uint8List Function(String) stringToBytes;
  final ECPoint Function(Uint8List) bytesToPoint;
  final Uint8List Function(ECPoint) pointToBytes;
  final ECPoint Function(TPublicKey) publicKeyToPoint;
  final TPublicKey Function(ECPoint) pointToPublicKey;

  PublicKeyPointByteStringFormat({
    required this.bytesToString,
    required this.stringToBytes,
    required this.bytesToPoint,
    required this.pointToBytes,
    required this.publicKeyToPoint,
    required this.pointToPublicKey,
  });

  String export(TPublicKey publicKey) => bytesToString(pointToBytes(publicKeyToPoint(publicKey)));
  TPublicKey import(String bytes) => pointToPublicKey(bytesToPoint(stringToBytes(bytes)));
}

class PublicKeyFormatRegistry {
  static final PublicKeyPointByteStringFormat<Secp256k1PublicKey> secp256k1Hex = PublicKeyPointByteStringFormat<Secp256k1PublicKey>(
    bytesToString: Hex.encode,
    stringToBytes: Hex.decode,
    bytesToPoint: (bytes) => Secp256k1.curve.decodePoint(bytes)!,
    pointToBytes: (point) => point.getEncoded(),
    publicKeyToPoint: (publicKey) => publicKey.Q,
    pointToPublicKey: Secp256k1PublicKey.fromPoint,
  );
}