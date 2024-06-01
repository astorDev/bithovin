import '../secp256k1.dart';

class PrivateKeyBigIntStringFormat<TPrivateKey> {
  String Function(BigInt) bigIntToString;
  BigInt Function(String) stringToBigInt;
  TPrivateKey Function(BigInt) bigIntToPrivateKey;
  BigInt Function(TPrivateKey) privateKeyToBigInt;

  PrivateKeyBigIntStringFormat({
    required this.bigIntToString,
    required this.stringToBigInt,
    required this.bigIntToPrivateKey,
    required this.privateKeyToBigInt,
  });

  String export(TPrivateKey privateKey) => bigIntToString(privateKeyToBigInt(privateKey));
  TPrivateKey import(String string) => bigIntToPrivateKey(stringToBigInt(string));
}

class PrivateKeyFormatRegistry {
  static final PrivateKeyBigIntStringFormat<Secp256k1PrivateKey> secp256k1Hex = PrivateKeyBigIntStringFormat<Secp256k1PrivateKey>(
    bigIntToString: (bigInt) => bigInt.toRadixString(16),
    stringToBigInt: (string) => BigInt.parse(string, radix: 16),
    bigIntToPrivateKey: Secp256k1PrivateKey.unsafeFromBigInt,
    privateKeyToBigInt: (privateKey) => privateKey.value.d!,
  );
}