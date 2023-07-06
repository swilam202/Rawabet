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
        embeddedImage: const AssetImage('assets/chat.png'),
        embeddedImageStyle: const QrEmbeddedImageStyle(
          size: Size.square(50),
        ),
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.circle,
          color: Color.fromRGBO(76, 238, 209, 1.0),
        ),
        dataModuleStyle: const QrDataModuleStyle(
            color: Color.fromRGBO(76, 238, 209, 1.0),
            dataModuleShape: QrDataModuleShape.circle),
      ),
    );
  }
}
