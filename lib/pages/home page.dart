import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String args = ModalRoute.of(context)!.settings.arguments as String;

    List names = ['mahmoudswilam24@gmail.com','mahmoudswilam02@gmail.com'];

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context,index){
        return GestureDetector(
            onTap: ()=>Navigator.of(context).pushNamed('texting',arguments: {'sender': args,'reciever':names[index]}),
            child:  ListTile(leading: Text(names[index],style: const TextStyle(fontSize: 20),), ),);
      },),
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
