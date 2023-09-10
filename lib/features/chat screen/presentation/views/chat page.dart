import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/core/utils/constants.dart';
import 'package:chatapp/core/widgets/loading%20state.dart';
import 'package:chatapp/features/account%20screen/presentation/views/account%20page.dart';
import 'package:chatapp/features/chat%20screen/presentation/controller/chat%20controller.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../componenets/chat bubble.dart';
import '../../../../componenets/toast.dart';
import '../../../../models/message model.dart';

// import '../componenets/chat bubble.dart';
// import '../componenets/toast.dart';
// import '../models/message model.dart';
// import 'Account.dart';

class ChatPage extends StatelessWidget {
  ChatController chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AccountPage(
                id: args['id'],
                name: args['name'],
                image: args['image'],
                isSelfAccount: false,
              ),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: CachedNetworkImageProvider(
                  args['image'],
                ),
              ),
              const SizedBox(width: 15),
              Text(args['name']),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: chatController.messages
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingState();
          } else {
            chatController.loadMessages(snapshot, args);

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: chatController.messagesList.length,
                      itemBuilder: (context, index) {
                        return (chatController.messagesList[index].sender ==
                                args['sender'])
                            ? Bubble1(
                                data: chatController
                                    .messagesList[index].messageContent,
                                isText:
                                    chatController.messagesList[index].isText,
                              )
                            : Bubble2(
                                data: chatController
                                    .messagesList[index].messageContent,
                                isText:
                                    chatController.messagesList[index].isText,
                              );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => chatController.sendGalleryImage(args),
                      icon: const Icon(
                        Icons.attachment,
                        color: kLightColor,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: chatController.controller,
                        onSubmitted: (data) => chatController.sendMessage(args),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.black,
                            ),
                          ),
                          hintText: 'Send Message...',
                          suffixIcon: IconButton(
                            onPressed: () => chatController.sendMessage(args),
                            icon: const Icon(
                              Icons.send,
                              color: kLightColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => chatController.sendCameraImage(args),
                      icon: const Icon(
                        Icons.camera,
                        color: kLightColor,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
