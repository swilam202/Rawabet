import 'package:chatapp/componenets/default%20drawer.dart';
import 'package:chatapp/controllers/home%20page%20controller.dart';
import 'package:chatapp/models/contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String args = ModalRoute.of(context)!.settings.arguments as String;
    HomePageController homePageController = Get.put(HomePageController(args: args));

    //CollectionReference reference = FirebaseFirestore.instance.collection('usrs');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Rawabet'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: homePageController.users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
                backgroundColor: Colors.indigoAccent,
              ),
            );
          } else {
            homePageController.contacts.value = [];
            homePageController.contactsList.value = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['id'] == args) {
                homePageController.contactsList.value =
                    snapshot.data!.docs[i]['contacts'];
                homePageController.userName.value =
                    snapshot.data!.docs[i]['name'];
                homePageController.userImage.value =
                    snapshot.data!.docs[i]['image'];
                break;
              }
            }

            // Query<Map<String, dynamic>> contactsDocs = FirebaseFirestore.instance.collection('users').where('id',isEqualTo: args);
            //contactsList = cont.get()[0]['contacts'];
            // getContacts(contactsDocs,contactsList);

            for (int i = 0; i < homePageController.contactsList.length; i++) {
              for (int j = 0; j < snapshot.data!.docs.length; j++) {
                if (homePageController.contactsList[i] ==
                    snapshot.data!.docs[j]['id']) {
                  homePageController.contacts.add(
                    Contacts(
                      homePageController.contactsList[i],
                      snapshot.data!.docs[j]['name'],
                      snapshot.data!.docs[j]['image'],
                    ),
                  );
                }
              }
            }

            return ListView.builder(
              itemCount: homePageController.contacts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Colors.grey[300],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        'texting',
                        arguments: {
                          'name': homePageController.contacts[index].name,
                          'sender': args,
                          'receiver': homePageController.contacts[index].id,
                          'image': homePageController.contacts[index].image,
                        },
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          splashColor: Colors.indigoAccent,
                          leading: CircleAvatar(
                            radius: 30.0,
                            // Increase the radius to make the avatar larger
                            backgroundImage: NetworkImage(
                                homePageController.contacts[index].image),
                            // child: Image(
                            //   image: NetworkImage(),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          title: Text(
                            '  ${homePageController.contacts[index].name}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
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
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: homePageController.contactController.value,
                    decoration: const InputDecoration(
                      labelText: 'Add contact',
                      hintText: 'Add someone to your contact',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: ()=>homePageController.addContacts(),
                  child: const Icon(Icons.add_call),
                ),
              ],
            ),
            backgroundColor: Colors.white,
          );
        },
        child: const Icon(Icons.message),
      ),
      drawer: DefaultDrawer(
        context: context,
        name: homePageController.userName.value,
        image: homePageController.userImage.value,
      ),
    );
  }
}

// void getContacts(Query<Map<String, dynamic>> query,List contactsList)async{
//
//   QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
//   contactsList= await querySnapshot.docs[0]['contacts'];
//
//
//
// }
