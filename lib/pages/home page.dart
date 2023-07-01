import 'package:chatapp/componenets/default%20drawer.dart';
import 'package:chatapp/models/contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String args = ModalRoute.of(context)!.settings.arguments as String;
    TextEditingController contactController = TextEditingController();

    Stream<QuerySnapshot> users =
        FirebaseFirestore.instance.collection('users').snapshots();
    //CollectionReference reference = FirebaseFirestore.instance.collection('usrs');
    List<Contacts> contacts = [];
    List contactsList = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Rawabet'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Colors.indigo, backgroundColor: Colors.indigoAccent),
            );
          } else {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['id'] == args) {
                contactsList = snapshot.data!.docs[i]['contacts'];
                break;
              }
            }

            for (int i = 0; i < contactsList.length; i++) {
              for (int j = 0; j < snapshot.data!.docs.length; j++) {
                if (contactsList[i] == snapshot.data!.docs[j]['id']) {
                  contacts.add(Contacts(
                      contactsList[i], snapshot.data!.docs[j]['name']));
                }
              }
            }

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(5),
                  shadowColor: Colors.blueGrey,
                  clipBehavior: Clip.hardEdge,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          'texting',
                          arguments: {
                            'name': contacts[index].name,
                            'sender': args,
                            'receiver': contacts[index].id,
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(52),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal[100],
                          ),
                          trailing: Expanded(
                            child: Text(
                              contacts[index].name,
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: contactController,
                      decoration: const InputDecoration(
                        labelText: 'Add contact',
                        hintText: 'Add someone to your contact',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.add_call),
                  ),
                ],
              ),
              backgroundColor: Colors.white);
        },
        child: const Icon(Icons.message),
      ),
      drawer: DefaultDrawer(
          context: context,
          name: 'name',
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR34hPo9zGkYxB2NKePgvPeImdm-CDTsHPrt4DFUyU_4A&s'),
    );
  }
}
