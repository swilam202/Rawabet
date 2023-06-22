import 'package:chatapp/componenets/chat%20bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message model.dart';

class Texting extends StatelessWidget {


  CollectionReference messages = FirebaseFirestore.instance.collection('mahmoudswilam02@gmail.com|mahmoudswilam24@gmail.com');
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: messages.orderBy('date',descending: true).snapshots(),
        builder: (context,snapshot){
          return  Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/chatimage.jpeg'),
                    fit: BoxFit.fill
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return (snapshot.data!.docs[index]['sender'] == args['sender'] )?bubble(snapshot.data!.docs[index]['message']):bubble2(snapshot.data!.docs[index]['message']);
                      },
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attachment,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data){
                        if(data.isNotEmpty){
                          messages.add({'message':data,'date':DateTime.now(),'sender':args['sender'],'reciever':args['reciever'],},);
                          controller.clear();
                          scrollController.animateTo(0, duration: const Duration(milliseconds: 1500), curve: Curves.bounceInOut);
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
                            color: Color.fromRGBO(67, 97, 255, 1.0),
                          ),
                        ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: const Color.fromRGBO(67, 97, 255, 1.0),
                      child: const Icon(Icons.mic),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}