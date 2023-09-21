import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/chat bubble.dart';
import '../../../../core/widgets/loading state.dart';
import '../../../account screen/presentation/views/account page.dart';
import '../controller/chat controller.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final ChatController chatController = ChatController();

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
            return const LoadingState();
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
