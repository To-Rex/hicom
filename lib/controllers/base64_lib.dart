import 'dart:convert';

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
}

void main() {
  String message = "Hello, Flutter!";
  String encoded = Base64EncoderDecoder.encodeBase64NoWrap(message);
  print("Encoded: $encoded");

  String decoded = Base64EncoderDecoder.decodeBase64NoWrap(encoded);
  print("Decoded: $decoded");
}
