import 'dart:convert';
import 'dart:typed_data';

import 'package:dart/secp256k1.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:test/test.dart';

void main() {

  Uint8List data = utf8.encode('Hello from dart secp256k1!');
  BigInt privateKey = BigInt.parse("41773220011020448796451705538427683430495588095087483091387299607380652481134");
  Point publicKey = Point(
    BigInt.parse("21285371770960987179343891334477951184299084915952205959541518459254283849951"),
    BigInt.parse("22671947423549970796294697518695530648245966458430018258533359741779880876856")
  );

  ECSignature signature = ECSignature(
    BigInt.parse("86058557054575571086167585107837415358165949453073739311202780092611888743858"),
    BigInt.parse("22076606289889717131594195825238606622326255596425005294818774860206769341915")
  );

  test('generatePrivateKey', () {
    var privateKey = Secp256k1.generatePrivateKey();
    print(privateKey);
  });

  test('get public key', () {
    var publicKey = Secp256k1.publicKeyFor(privateKey);
    print(publicKey);
  });

  test('sign data', () {
    var signature = Secp256k1.generateSignature(data, privateKey);
    print(signature);
  });

  test('verify signature', () {
    var verified = Secp256k1.verifySignature(data, signature, publicKey);
    print(verified);
    expect(verified, true);
  });
}