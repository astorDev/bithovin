import 'dart:typed_data';

class Hex {
  String value;

  Hex(this.value);

  factory Hex.fromBytes(Uint8List bytes) {
    var sb = StringBuffer();
    for (var b in bytes) {
      var s = b.toRadixString(16);
      if (s.length == 1) {
        s = '0$s';
      }
      sb.write(s);
    }
    
    var value = sb.toString();
    return Hex(value);
  }

  static String encode(Uint8List bytes) {
    var parts = bytes.map((e) => e.toRadixString(16).padLeft(2, '0'));
    return parts.join();
  }

  static Uint8List decode(String hex) {
    var raw = List.generate(
      hex.length ~/ 2, 
      (i) => int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16)
    );
    
    return Uint8List.fromList(raw);
  }

  Uint8List toBytes() {
    var str = value;

    if (str.length % 2 != 0) {
      str = "0$str";
    }

    var l = str.length ~/ 2;
    var result = Uint8List(l);
    for (var i = 0; i < l; ++i) {
      var x = int.parse(str.substring(i * 2, (2 * (i + 1))), radix: 16);
      if (x.isNaN) {
        throw ArgumentError('Expected hex string');
      }
      result[i] = x;
    }
    
    return result;
  }

  @override
  String toString() => value;
}

extension HexUint8ListExtension on Uint8List {
  Hex toHex() => Hex.fromBytes(this);
}