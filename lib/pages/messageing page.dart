import 'package:chatapp/componenets/chat%20bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message model.dart';

class Texting extends StatelessWidget {


  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  
  List<Message> messagesList = <Message>[];




  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title:Row(children: [
          CircleAvatar(
            radius: 20.0, // Increase the radius to make the avatar larger
            backgroundImage: NetworkImage(args['image']),
            // child: Image(
            //   image: NetworkImage(),
            //   fit: BoxFit.cover,
            // ),
          ),
          const SizedBox(width: 15,),
          Text(args['name']),
        ],),

        centerTitle: true,

      ),
      body: StreamBuilder(
        stream: messages.orderBy('date',descending: true).snapshots(),
        builder: (context,snapshot){
         if(snapshot.connectionState == ConnectionState.waiting){
           return const Center(child: CircularProgressIndicator(color: Colors.indigo,backgroundColor: Colors.indigoAccent),);
         }
         else{
           messagesList = [];
           for (int i = 0; i < snapshot.data!.docs.length; i++) {
             var message = snapshot.data!.docs[i];
             if ((message['sender'] == args['sender'] && message['receiver'] == args['receiver']) ||
                 (message['sender'] == args['receiver'] && message['receiver'] == args['sender'])) {
               messagesList.add(Message(message['message'], message['sender'], message['receiver']));
             }
           }

           return  Column(
             children: [
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ListView.builder(
                     reverse: true,
                     shrinkWrap: true,
                     itemCount: messagesList.length,
                     itemBuilder: (context, index) {
                       return (messagesList[index].sender == args['sender'] )?bubble(messagesList[index].messageContent):bubble2(messagesList[index].messageContent);
                     },
                   ),
                 ),
               ),
               Row(
                 children: [
                   IconButton(
                     onPressed: () {},
                     icon: const Icon(
                       Icons.attachment,
                       color: Colors.indigo,
                     ),
                   ),
                   Expanded(
                     child: TextField(
                       controller: controller,
                       onSubmitted: (data){
                         if(data.isNotEmpty){
                           messages.add({'date':DateTime.now(),'message':data,'receiver':args['receiver'],'sender':args['sender'],},);
                           messagesList.add(Message(data, args['sender'], args['receiver']));
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
                             color: Colors.indigo,
                           ),
                         ),),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: FloatingActionButton(
                       onPressed: () {},

                       backgroundColor: Colors.indigo,
                       child: const Icon(Icons.mic),
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