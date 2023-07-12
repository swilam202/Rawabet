import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:chatapp/black%20box.dart';
import 'package:chatapp/componenets/chat%20bubble.dart';
import 'package:chatapp/pages/Account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/message model.dart';

class Texting extends StatelessWidget {
  CollectionReference messages =
  FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();

  List<Message> messagesList = <Message>[];

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    File file;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () =>
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      Account(
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
                radius: 20.0, // Increase the radius to make the avatar larger
                backgroundImage: NetworkImage(args['image']),
                // child: Image(
                //   image: NetworkImage(),
                //   fit: BoxFit.cover,
                // ),
              ),
              const SizedBox(width: 15),
              Text(args['name']),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: messages.orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(27, 150, 241, 1.0),
                backgroundColor: Color.fromRGBO(18, 109, 171, 1.0),),
            );
          } else {
            messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              var message = snapshot.data!.docs[i];
              if ((message['sender'] == args['sender'] &&
                  message['receiver'] == args['receiver']) ||
                  (message['sender'] == args['receiver'] &&
                      message['receiver'] == args['sender'])) {
                messagesList.add(Message(
                  message['message'],
                    message['sender'],
                    message['receiver'],message['isText'],));
              }
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return (messagesList[index].sender == args['sender'])
                            ? Bubble1(data: messagesList[index].messageContent,
                            isText: messagesList[index].isText,)
                            : Bubble2(data: messagesList[index].messageContent,
                            isText: messagesList[index].isText,);
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async{
                        ImagePicker imagePicker = ImagePicker();
                      var image = await imagePicker.pickImage(source: ImageSource.gallery);
                      if(image != null){
                        file = File(image.path);
                        String name = basename(image.path);
                        var reference = FirebaseStorage.instance.ref('images/$name');
                        await reference.putFile(file);
                        String url = await reference.getDownloadURL();
                        await messages.add(
                          {
                            'date': DateTime.now(),
                            'isText': false,
                            'message':  url,
                            'receiver': args['receiver'],
                            'sender': args['sender'],
                          },
                        );
                        messagesList.add(Message(
                          url, args['sender'], args['receiver'],false,),);
                      }
                      else{
                        Fluttertoast.showToast(msg: 'Something went wrong please try again');
                      }
                      },
                      icon: const Icon(
                        Icons.attachment,
                        color: Color.fromRGBO(27, 150, 241, 1.0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          if (data.isNotEmpty) {
                            messages.add(
                              {
                                'date': DateTime.now(),
                                'isText': true,
                                'message': data,
                                'receiver': args['receiver'],
                                'sender': args['sender'],
                              },
                            );
                            messagesList.add(Message(
                                data, args['sender'], args['receiver'],true,),);
                            controller.clear();
                            scrollController.animateTo(0,
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.bounceInOut,);
                          }
                        },
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send,
                              color: Color.fromRGBO(27, 150, 241, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () async{
                        ImagePicker imagePicker = ImagePicker();
                        var image = await imagePicker.pickImage(source: ImageSource.camera);
                        if(image != null){
                          file = File(image.path);
                          String name = basename(image.path);
                          var reference = FirebaseStorage.instance.ref('images/$name');
                          await reference.putFile(file);
                          String url = await reference.getDownloadURL();
                          await messages.add(
                            {
                              'date': DateTime.now(),
                              'isText': false,
                              'message':  url,
                              'receiver': args['receiver'],
                              'sender': args['sender'],
                            },
                          );
                          messagesList.add(Message(
                            url, args['sender'], args['receiver'],false,),);
                        }
                        else{
                          Fluttertoast.showToast(msg: 'Something went wrong please try again');
                        }
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Color.fromRGBO(27, 150, 241, 1.0),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: FloatingActionButton(
                    //     onPressed: () {
                    //
                    //     },
                    //     backgroundColor: const Color.fromRGBO(
                    //         63, 196, 168, 1.0),
                    //     child: const Icon(Icons.mic),
                    //   ),
                    // ),
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
