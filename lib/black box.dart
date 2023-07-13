//import 'dart:convert';

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


// class Encrypter {
//   // static String encryption(String data) {
//   //   List<int> list = utf8.encode(data);
//   //   for (int i = 0; i < list.length; i++) {
//   //     list[i] += 13;
//   //   }
//   //   return utf8.decode(list);
//   // }
//
//   static List<int> encryption(String data) {
//     //  List<int> list = AsciiEncoder().convert(data);
//
//     // return AsciiDecoder().convert(list);
//     List<int> list = utf8.encode(data);
//     // for (int i = 0; i < list.length; i++) {
//     //   list[i] += 13;
//     // }
//     //return utf8.decode(list);
//     return list;
//   }
//
//   // static String decryption(String data) {
//   //   List<int> list = utf8.encode(data);
//   //   for (int i = 0; i < list.length; i++) {
//   //     list[i] -= 13;
//   //   }
//   //   return utf8.decode(list);
//   // }
//
//   static String decryption(List data) {
//     List<int> list = data as List<int>;
//     //  List<int> list = AsciiEncoder().convert(data);
//     // for (int i = 0; i < data.length; i++) {
//     //   data[i] -= 13;
//     // }
//     // utf8.decode(data);
//
//     //return AsciiDecoder().convert(list);/
//     String s = utf8.decode(list);
//     return s;
//   }
// }