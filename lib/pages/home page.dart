import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String args = ModalRoute.of(context)!.settings.arguments as String;



    Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body:StreamBuilder(
        stream: users,
        builder: (context,snapshot){
         late List contacts;
            for(int i = 0;i< snapshot.data!.docs.length;i++){
              if(snapshot.data!.docs[i]['id'] == args){
                contacts = snapshot.data!.docs[i]['contacts'];
                break;
              }
            }
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context,index){
              return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('texting',arguments: {'sender': args,'receiver': contacts[index],},);
                  },
                  child: ListTile(trailing: Expanded(child: Text(contacts[index],style: const TextStyle(fontSize: 20),textAlign: TextAlign.start,),),),);

            },);
        },
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: (){
           Get.bottomSheet(
               const Padding(
                 padding: EdgeInsets.all(8.0),
                 child: TextField(
                   decoration: InputDecoration(
                       labelText: 'Add contact',
                       hintText: 'Add someone to your contact'
                   ),
                 ),
               ),
             backgroundColor: Colors.white
           );
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
