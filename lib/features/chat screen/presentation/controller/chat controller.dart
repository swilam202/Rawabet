import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/message model.dart';
import '../../../../core/utils/notifications services.dart';
import '../../../../core/utils/teke image.dart';
import '../../../../core/widgets/toast.dart';

class ChatController extends GetxController {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<Message> messagesList = <Message>[];

  void loadMessages(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, Map args) {
    messagesList = [];
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      QueryDocumentSnapshot<Object?> message = snapshot.data!.docs[i];
      if ((message['sender'] == args['sender'] &&
              message['receiver'] == args['receiver']) ||
          (message['sender'] == args['receiver'] &&
              message['receiver'] == args['sender'])) {
        messagesList.add(
          Message(
            message['message'],
            message['sender'],
            message['receiver'],
            message['isText'],
          ),
        );
      }
    }
  }

  void sendGalleryImage(Map args) async {
    String? url = await takeImage(ImageSource.gallery);
    if (url != null) {
      await messages.add(
        {
          'date': DateTime.now(),
          'isText': false,
          'message': url,
          'receiver': args['receiver'],
          'sender': args['sender'],
        },
      );
      messagesList.add(
        Message(
          url,
          args['sender'],
          args['receiver'],
          false,
        ),
      );
      NotificationsServices.pushNotification(
          token: args['token'],
          title: args['senderName'],
          body: 'Sent and image');
    } else {
      showToast('Something went wrong please try again');
    }
  }

  void sendMessage(Map args) async {
    if (controller.text.isNotEmpty) {
      messages.add(
        {
          'date': DateTime.now(),
          'isText': true,
          'message': controller.text,
          'receiver': args['receiver'],
          'sender': args['sender'],
        },
      );
      messagesList.add(
        Message(
          controller.text,
          args['sender'],
          args['receiver'],
          true,
        ),
      );

      NotificationsServices.pushNotification(
        token: args['token'],
        title: args['senderName'],
        body: controller.text,
      );

      controller.clear();
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.bounceInOut,
        );
      }
    }
  }

  void sendCameraImage(Map args) async {
    String? url = await takeImage(ImageSource.camera);

    if (url != null) {
      await messages.add(
        {
          'date': DateTime.now(),
          'isText': false,
          'message': url,
          'receiver': args['receiver'],
          'sender': args['sender'],
        },
      );
      messagesList.add(
        Message(
          url,
          args['sender'],
          args['receiver'],
          false,
        ),
      );
      NotificationsServices.pushNotification(
          token: args['token'],
          title: args['senderName'],
          body: 'Sent and image');
    } else {
      showToast('Something went wrong please try again');
    }
  }
}
