import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomQRCode extends StatelessWidget {
  CustomQRCode(this.url, {super.key});

  String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: QrImageView(
        data: url,
        version: QrVersions.auto,
        size: 320,
        gapless: false,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Color.fromRGBO(27, 150, 241, 1.0),
        ),
        dataModuleStyle: const QrDataModuleStyle(
          color: Color.fromRGBO(27, 150, 241, 1.0),
          dataModuleShape: QrDataModuleShape.square,
        ),
      ),
    );
  }
}
