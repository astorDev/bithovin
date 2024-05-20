import 'dart:convert';
import 'dart:typed_data';

import 'package:dart/secp256k1.dart';
import 'package:test/test.dart';

void main() {

  Uint8List data = utf8.encode('Hello from dart secp256k1!');
  BigInt privateKey = BigInt.parse("41773220011020448796451705538427683430495588095087483091387299607380652481134");

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
    var publicKey = Secp256k1.publicKeyFor(privateKey);
    var signature = Secp256k1.generateSignature(data, privateKey);
    var verified = Secp256k1.verifySignature(data, signature, publicKey);
    expect(verified, true);
  });
}