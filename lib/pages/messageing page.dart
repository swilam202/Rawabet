import 'package:chatapp/componenets/chat%20bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Texting extends StatelessWidget {
  List<String> list = [
    'adfa',
    'daf',
    'adf',
    'afd',
    'adf',
    'adfa',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
    'kdajfaiufd akdfkdsfn aieurjkfds,.anf ahdfjaioudj ahdsfaihdsoif alkdfiaufeidsk akjfheuyh',
  ];

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return bubble(list[index]);
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
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onSubmitted: (data){
                    messages.add({'message':data});
                    controller.clear();
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
              )
            ],
          ),
        ],
      ),
    );
  }
}