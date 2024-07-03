import 'dart:convert';
import 'dart:typed_data';

import 'base64_lib.dart';

class Tea {
  static const int TIMES = 32;
  static const int DELTA = 0x9e3779b9;
  static const List<int> BYTES = [104, 105, 99, 111, 109, 116, 101, 97]; // 'hicomtea' in bytes

  static List<int> byte2uint(Uint8List bs) {
    var buffer = ByteData.sublistView(bs);
    return List.generate(bs.length ~/ 4, (i) => buffer.getUint32(i * 4, Endian.little));
  }

  static Uint8List uint2byte(List<int> uint) {
    var buffer = ByteData(uint.length * 4);
    for (var i = 0; i < uint.length; i++) {
      buffer.setUint32(i * 4, uint[i], Endian.little);
    }
    return buffer.buffer.asUint8List();
  }

  static int int2uint(int v) {
    return v & 0xffffffff;
  }

  static int uintAdd(int l) {
    return l & 0xffffffff;
  }

  static int uintSub(int l, int sub) {
    return (l - sub) & 0xffffffff;
  }

  static int uintLeft(int l, int offset) {
    return (l << offset) & 0xffffffff;
  }

  static int uintRight(int l, int offset) {
    return (l >> offset);
  }

  static Uint8List encrypt(Uint8List bs, List<int> keys, int delta) {
    int sum = 0;
    var v = byte2uint(bs);
    for (var i = 0; i < TIMES; i++) {
      sum = uintAdd(sum + delta);
      v[0] = uintAdd(v[0] + (uintAdd(uintLeft(v[1], 6) + keys[0]) ^ uintAdd(v[1] + sum) ^ uintAdd(uintRight(v[1], 3) + keys[1])));
      v[1] = uintAdd(v[1] + (uintAdd(uintLeft(v[0], 6) + keys[2]) ^ uintAdd(v[0] + sum) ^ uintAdd(uintRight(v[0], 3) + keys[3])));
    }
    return uint2byte(v);
  }

  static Uint8List decrypt(Uint8List bs, List<int> keys, int delta, int sum) {
    var v = byte2uint(bs);
    for (var i = 0; i < TIMES; i++) {
      v[1] = uintSub(v[1], uintAdd(uintLeft(v[0], 6) + keys[2]) ^ uintAdd(v[0] + sum) ^ uintAdd(uintRight(v[0], 3) + keys[3]));
      v[0] = uintSub(v[0], uintAdd(uintLeft(v[1], 6) + keys[0]) ^ uintAdd(v[1] + sum) ^ uintAdd(uintRight(v[1], 3) + keys[1]));
      sum = uintSub(sum, delta);
    }
    return uint2byte(v);
  }

  static int ubyteLeft(int v, int offset) {
    return (v << offset) & 0xff;
  }

  static int ubyteRight(int v, int offset) {
    return (v >> offset) & 0xff;
  }

  static int ubyteAdd(int v) {
    return v & 0xff;
  }

  static int ubyteSub(int v, int sub) {
    return (v - sub) & 0xff;
  }

  static int encryptByte(int b, List<int> keys, int index) {
    int m = BYTES[index % 8] & 0xff;
    int k = keys[index % 4] & 0xff;
    int s = b & 0xff;
    for (var i = 0; i < TIMES; i++) {
      s = ubyteAdd(s + (ubyteAdd(ubyteLeft(m, 3) + k) ^ ubyteAdd(ubyteRight(m, 2) + k)));
    }
    return s;
  }

  static int decryptByte(int b, List<int> keys, int index) {
    int m = BYTES[index % 8] & 0xff;
    int k = keys[index % 4] & 0xff;
    int s = b & 0xff;
    for (var i = 0; i < TIMES; i++) {
      s = ubyteSub(s, ubyteAdd(ubyteLeft(m, 3) + k) ^ ubyteAdd(ubyteRight(m, 2) + k));
    }
    return s;
  }

  static dynamic encryptData(Uint8List bs, Uint8List key, bool isBase64) {
    if (key.length != 16) {
      return null;
    }

    int lenBs = bs.length;
    int remain = lenBs % 8;
    int align = lenBs - remain;
    var keys = byte2uint(key);
    int delta = int2uint(DELTA);

    var encryptedBs = Uint8List.fromList(bs);

    for (var i = 0; i < align; i += 8) {
      var tmp = bs.sublist(i, i + 8);
      encryptedBs.setRange(i, i + 8, encrypt(tmp, keys, delta));
    }

    for (var i = align; i < lenBs; i++) {
      encryptedBs[i] = encryptByte(bs[i], keys, i);
    }

    if (isBase64) {
      return base64Encode(encryptedBs);
    } else {
      return encryptedBs;
    }
  }


  static dynamic decryptData(Uint8List bs, Uint8List key, bool isBase64) {
    if (key.length != 16) {
      return null;
    }

    if (isBase64) {
      // Decode the base64 encoded string to Uint8List
      //bs = base64Decode(utf8.decode(bs));
      bs = Base64EncoderDecoder.decodeBase64(utf8.decode(bs));
    }

    int lenBs = bs.length;
    int remain = lenBs % 8;
    int align = lenBs - remain;
    int delta = int2uint(DELTA);
    var keys = byte2uint(key);
    int sum = uintAdd(TIMES * delta);

    var decryptedBs = Uint8List.fromList(bs);

    for (var i = 0; i < align; i += 8) {
      var tmp = bs.sublist(i, i + 8);
      decryptedBs.setRange(i, i + 8, decrypt(tmp, keys, delta, sum));
    }

    for (var i = align; i < lenBs; i++) {
      decryptedBs[i] = decryptByte(bs[i], keys, i);
    }

    return decryptedBs;
  }

  static String encryptTea(String data, String key) {
    var encryptedBytes = encryptData(Uint8List.fromList(utf8.encode(data)), Uint8List.fromList(utf8.encode(key)), true);
    //return encryptedBytes.toString().replaceAll('/', '%2F').replaceAll('+', '%2B').replaceAll('=', '%3D');
    return encryptedBytes.toString().replaceAll('/', '%2F').replaceAll('+', '%2B').replaceAll('=', '%3D').replaceAll('\n', '%0A').replaceAll('\r', '%0D').replaceAll('\t', '%09').replaceAll(' ', '%20').replaceAll(RegExp(r"[^\x00-\x7F]+"), "");
    //return encryptedBytes.toString().replaceAll(RegExp(r"[^\x00-\x7F]+"), "");
  }

  static String decryptTea(String data, String key) {
    var decryptedBytes = decryptData(Uint8List.fromList(utf8.encode(data)), Uint8List.fromList(utf8.encode(key)), true);
    return utf8.decode(decryptedBytes);
  }

}



String decodeBase64Url(String encodedStr) {
  var urlDecodedStr = Uri.decodeComponent(encodedStr);
  int paddingNeeded = urlDecodedStr.length % 4;
  if (paddingNeeded != 0) {
    urlDecodedStr += '=' * (4 - paddingNeeded);
  }

  return urlDecodedStr;
}
