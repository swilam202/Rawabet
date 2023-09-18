import 'package:chatapp/core/utils/teke%20image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../componenets/toast.dart';
import '../../../../models/message model.dart';


class ChatController extends GetxController{
  CollectionReference messages =
  FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<Message> messagesList = <Message>[];

  void loadMessages(AsyncSnapshot<QuerySnapshot<Object?>> snapshot,Map args){
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

  void sendGalleryImage(Map args)async{

      String? url = await takeImage(ImageSource.gallery);
      if(url != null){
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
        );}



       else {
        showToast('Something went wrong please try again');
      }
    }

    void sendMessage(Map args) {
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
        controller.clear();
        if(scrollController.hasClients){
          scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.bounceInOut,
        );
        }
      }
    }

    void sendCameraImage(Map args)async{
      String? url = await takeImage(ImageSource.camera);

      if(url != null){
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
        } else {
          showToast('Something went wrong please try again');
        }

    }
}
