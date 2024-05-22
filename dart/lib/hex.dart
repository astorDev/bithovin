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

extension HexExtension on Uint8List {
  Hex toHex() => Hex.fromBytes(this);
}