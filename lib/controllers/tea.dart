
import'dart:convert';
import 'dart:typed_data';

class TEA {
  static const int TIMES = 32; // 迭代次数，不可修改
  static const int DELTA = 0x9e3779b9; // 这是算法标准给的值，不可修改
  static const List<int> BYTES = [104, 105, 99, 111, 109, 116, 101, 97];


  /// byte数组转uint数组，4byte转一个uint，不足4byte丢弃
  static List<int> byte2uint(List<int> bs) {
    List<int> uint = List<int>.filled(bs.length ~/ 4, 0);
    for (int i = 0; i < uint.length; i++) {
      int start = i * 4;
      for (int j = 4; j > 0; j--) {
        uint[i] <<= 8;
        uint[i] |= bs[start + j - 1] & 0xff;
      }
    }
    return uint;
  }

  /// uint数组转byte数组，1转4
  static List<int> uint2byte(List<int> uint) {
    List<int> bs = List<int>.filled(uint.length * 4, 0);
    for (int i = 0; i < uint.length; i++) {
      int start = i * 4;
      for (int j = 0; j < 4; j++) {
        bs[start + j] = uint[i] & 0xff;
        uint[i] >>= 8;
      }
    }
    return bs;
  }

  /// int 转 uint
  static int int2uint(int v) {
    return v & 0xffffffff;
  }

  /// uint方式增加
  static int uintAdd(int l) {
    while (l > 0xffffffff) {
      l -= 0x100000000;
    }
    return l;
  }

  /// uint方式减少
  static int uintSub(int l, int sub) {
    if (l >= sub) {
      return l - sub;
    } else {
      return l + 0x100000000 - sub;
    }
  }

  /// uint方式左移
  static int uintLeft(int l, int offset) {
    return (l << offset) & 0xffffffff;
  }

  /// uint方式右移
  static int uintRight(int l, int offset) {
    return ((l & 0xffffffff) >> offset) & 0xffffffff;
  }

  /// TEA 加密算法
  static List<int> encrypt2(List<int> bs, List<int> keys, int delta) {
    int sum = 0;
    List<int> v = byte2uint(bs);
    for (int j = 0; j < TIMES; j++) {
      sum = uintAdd(sum + delta);
      v[0] = uintAdd(v[0] + (uintAdd(uintLeft(v[1], 6) + keys[0]) ^
      uintAdd(v[1] + sum) ^
      uintAdd(uintRight(v[1], 3) + keys[1])));
      v[1] = uintAdd(v[1] + (uintAdd(uintLeft(v[0], 6) + keys[2]) ^
      uintAdd(v[0] + sum) ^
      uintAdd(uintRight(v[0], 3) + keys[3])));
    }
    return uint2byte(v);
  }

  /// TEA解密算法，每次操作可以处理
  static List<int> decrypt2(List<int> bs, List<int> keys, int delta, int sum) {
    List<int> v = byte2uint(bs);

    for (int j = 0; j < TIMES; j++) {
      v[1] = uintSub(
          v[1],
          uintAdd(uintLeft(v[0], 6) + keys[2]) ^
          uintAdd(v[0] + sum) ^
          uintAdd(uintRight(v[0], 3) + keys[3]));
      v[0] = uintSub(
          v[0],
          uintAdd(uintLeft(v[1], 6) + keys[0]) ^
          uintAdd(v[1] + sum) ^
          uintAdd(uintRight(v[1], 3) + keys[1]));
      sum = uintSub(sum, delta);
    }

    return uint2byte(v);
  }

  static int ubyteLeft(int v, int offset) {
    return (v << offset) & 0xff;
  }

  static int ubyteRight(int v, int offset) {
    return ((v & 0xff) >> offset) & 0xff;
  }

  static int ubyteAdd(int v) {
    while (v > 0xff) {
      v -= 0x100;
    }
    return v;
  }

  static int ubyteSub(int v, int sub) {
    if (v >= sub) {
      return v - sub;
    }
    while (v < sub) {
      v += 0x100;
    }
    return v - sub;
  }

  /// 字节加密
  static int encryptByte(int b, List<int> keys, int index) {
    int m = BYTES[index % 8] & 0xff;
    int k = keys[index % 4] & 0xff;
    int s = b & 0xff;
    for (int j = 0; j < TIMES; j++) {
      s = ubyteAdd(s + (ubyteAdd(ubyteLeft(m, 3) + k) ^
      ubyteAdd(ubyteRight(m, 2) + k)));
    }
    return s & 0xff;
  }

  /// 字节解密
  static int decryptByte(int b, List<int> keys, int index) {
    int m = BYTES[index % 8] & 0xff;
    int k = keys[index % 4] & 0xff;
    int s = b & 0xff;
    for (int j = 0; j < TIMES; j++) {
      s = ubyteSub(s, ubyteAdd(ubyteLeft(m, 3) + k) ^
      ubyteAdd(ubyteRight(m, 2) + k));
    }
    return s & 0xff;
  }

  /// TEA加密
  static List<int> encrypt(List<int> bs, List<int> key, bool isBase64)
  {
    // if (key.length != 16) {
    //   return null;
    // }
      var bb = Uint8List(bs.length);
      for (int i = 0; i < bs.length; i++) {
        bb[i] = bs[i];
      }

      int len = bs.length;
      int remain = len % 8;
      int align = len - remain;
      List<int> keys = byte2uint(key);
      int delta = int2uint(DELTA);
      for (int i = 0; i < align; i += 8) {
        List<int> tmp = List<int>.from(bb.sublist(i, i + 8));
        tmp = encrypt2(tmp, keys, delta);
        bb.setRange(i, i + 8, tmp);
      }
      for (int i = align; i < len; i++) {
        bb[i] = encryptByte(bs[i], keys, i);
      }

      if (isBase64) {
        return base64.encode(bb).codeUnits;
      } else {
        return bb;
      }
  }

  static String encryptTEA(String data, String key) {
    List<int> bytes = encrypt(data.codeUnits, key.codeUnits, true);
    return String.fromCharCodes(bytes as Iterable<int>);
  }

  static String decryptTEA(String data, String key) {
    List<int> bytes = decrypt(data.codeUnits, key.codeUnits, true);
    return String.fromCharCodes(bytes as Iterable<int>);
  }

  static String byteArrayToHex(List<int> a) {
    return a.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
  }

  static String longArrayToHex(List<int> a) {
    return a.map((b) => b.toRadixString(16)).join(' ');
  }

  /// TEA解密
  static List<int> decrypt(List<int> bs, List<int> key, bool isBase64) {
    // if (key.length != 16) {
    //   return null;
    // }
    if (isBase64) {
      bs = base64.decode(String.fromCharCodes(bs));
    }

    int len = bs.length;
    int remain = len % 8;
    int align = len - remain;
    int delta = int2uint(DELTA);
    List<int> keys = byte2uint(key);
    int sum = uintAdd(TIMES * delta);

    for (int i = 0; i < align; i += 8) {
      List<int> tmp = List<int>.from(bs.sublist(i, i + 8));
      tmp = decrypt2(tmp, keys, delta, sum);
      bs.setRange(i, i + 8, tmp);
    }
    for (int i = align; i < len; i++) {
      bs[i] = decryptByte(bs[i], keys, i);
    }

    return bs;
  }

}

