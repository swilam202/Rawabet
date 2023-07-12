import 'dart:convert';

// extension encrypter on String {
//   String encryption(String data) {
//     List<int> list = AsciiEncoder().convert(data);
//     for (int i = 0; i < list.length; i++) {
//       list[i] += 13;
//     }
//     return AsciiDecoder().convert(list);
//   }
//
//   String decryption(String data) {
//     List<int> list = AsciiEncoder().convert(data);
//     for (int i = 0; i < list.length; i++) {
//       list[i] -= 13;
//     }
//
//     return AsciiDecoder().convert(list);
//   }
// }


// class encrypter {
//   static String encryption(String data) {
//     List<int> list = utf8.encode(data);
//     for (int i = 0; i < list.length; i++) {
//       list[i] += 13;
//     }
//     return utf8.decode(list);
//   }
//
//   static String decryption(String data) {
//     List<int> list = utf8.encode(data);
//     for (int i = 0; i < list.length; i++) {
//       list[i] -= 13;
//     }
//     return utf8.decode(list);
//   }
// }