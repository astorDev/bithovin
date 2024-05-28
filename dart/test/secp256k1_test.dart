import 'dart:convert';

import 'package:bithovin/bithovin.dart';
import 'package:test/test.dart';

import 'printed_extensions.dart';

void main() {
  var dataFromCSharp = utf8.encode('Hello, secp256k1 with C#');
  var signatureFromCSharp = ECSignature(
    BigInt.parse("36019585936424807702067775695488245732523976579610140319465179840471756082127"),
    BigInt.parse("41226921866506014482256410953376195772128906272442926381814048747893010526424")
  );

  var publicKeyFromCsharp = Secp256k1PublicKey.fromRawBigIntegers(
    BigInt.parse("8795278746697027836736556376014590967812476665167364650216503281309786723044"),
    BigInt.parse("107748829798493369459082063025509742122394492767277437517191482000758999454504")
  );

  test('sign and verify signature using generated keys', () {
    var data = utf8.encode('Hello from dart secp256k1!');
    var privateKey = Secp256k1PrivateKey.generateNew().printed(name: "privateKey");
    var signature = privateKey.sign(data).printed(name: "signature");
    var publicKey = privateKey.getPublicKey().printed(name: "publicKey");
    var verified = publicKey.verify(data, signature).printed(name: "verified");
    
    expect(verified, true);
  });

  test('verify from C#', () {
    var verified = publicKeyFromCsharp.verify(dataFromCSharp, signatureFromCSharp).printed(name: "verified");
    
    expect(verified, true);
  });

  test('export and import public key', () {
    var exported = publicKeyFromCsharp.Q.getEncoded(true).toHex().printed(name: "exported");
    var imported = Secp256k1.curve.decodePoint(exported.toBytes()).printed(name: "imported");

    expect(imported, publicKeyFromCsharp);
  });

  test('export and import signature', () {
    var exported = signatureFromCSharp.toSec1Der().hex.printed(name: "exported");
    var imported = exported.toSec1Der().toECSignature().printed(name: "imported");

    expect(signatureFromCSharp, imported);
  });
}