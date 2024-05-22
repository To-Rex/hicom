import 'dart:convert';
import 'dart:typed_data';

class Base64EncoderDecoder {
  static const List<String> base64Chars = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
  ];

  static String encodeBase64NoWrap(String message) {
    List<int> bytes = utf8.encode(message);
    List<List<int>> byteGroups = [];
    for (int i = 0; i < bytes.length; i += 3) {
      byteGroups.add(bytes.sublist(i, i + 3));
    }

    if (byteGroups.last.length < 3) {
      byteGroups.last.addAll(List.filled(3 - byteGroups.last.length, 0));
    }

    String encoded = "";
    for (var group in byteGroups) {
      int value = (group[0] << 16) | (group[1] << 8) | group[2];
      encoded += base64Chars[(value >> 18) & 0x3f];
      encoded += base64Chars[(value >> 12) & 0x3f];
      encoded += base64Chars[(value >> 6) & 0x3f];
      encoded += base64Chars[value & 0x3f];
    }

    encoded = encoded.replaceAll(RegExp(r"="), "");
    return encoded;
  }

  static String decodeBase64NoWrap(String encoded) {
    List<String> charGroups = [];
    int charGroupLength = (encoded.length / 4).floor();
    for (int i = 0; i < charGroupLength; i++) {
      charGroups.add(encoded.substring(i * 4, (i + 1) * 4));
    }

    List<int> bytes = [];
    for (var group in charGroups) {
      int value = 0;
      for (int i = 0; i < group.length; i++) {
        value |= base64Chars.indexOf(group[i]) << (18 - 6 * i);
      }
      bytes.add((value >> 16) & 0xff);
      bytes.add((value >> 8) & 0xff);
      bytes.add(value & 0xff);
    }
    return utf8.decode(bytes.where((byte) => byte != 0).toList());
  }

  static Uint8List decodeBase64(String base64String) {
    base64String = Uri.decodeFull(base64String);
    while (base64String.length % 4 != 0) {
      base64String += '=';
    }
    base64String = base64String.replaceAll(RegExp(r'[\n\r]'), '');
    List<int> decodedBytes = base64.decode(base64String);
    Uint8List result = Uint8List.fromList(decodedBytes);
    return result;
  }

  static Uint8List encodeBase64(String message) {
    String base64String = base64Encode(utf8.encode(message));
    return Uint8List.fromList(utf8.encode(base64String));
  }
}