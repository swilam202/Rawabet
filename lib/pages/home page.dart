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
    String id = ModalRoute.of(context)!.settings.arguments as String;
    HomePageController homePageController = Get.put(HomePageController(id: id));

    //CollectionReference reference = FirebaseFirestore.instance.collection('usrs');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rawabet'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: homePageController.users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(27, 150, 241, 1.0),
                backgroundColor: Color.fromRGBO(18, 109, 171, 1.0),
              ),
            );
          }

          // else if(!snapshot.hasData || snapshot.hasError){
          //   return const Center(
          //     child: Text('No Contacts yet add ones'),
          //   );
          // }
          else {
            homePageController.contacts.value = [];
            homePageController.contactsList.value = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              if (snapshot.data!.docs[i]['id'] == id) {
                homePageController.contactsList.value =
                    snapshot.data!.docs[i]['contacts'];
                homePageController.userName.value =
                    snapshot.data!.docs[i]['name'];
                homePageController.userImage.value =
                    snapshot.data!.docs[i]['image'];
                break;
              }
            }

            // Query<Map<String, dynamic>> contactsDocs = FirebaseFirestore.instance.collection('users').where('id',isEqualTo: id);
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        'texting',
                        arguments: {
                          'id': homePageController.contacts[index].id,
                          'name': homePageController.contacts[index].name,
                          'sender': id,
                          'receiver': homePageController.contacts[index].id,
                          'image': homePageController.contacts[index].image,
                        },
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          splashColor: const Color.fromRGBO(27, 150, 241, 1.0),
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
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Divider(
                            thickness: 1,
                            endIndent: 15,
                            indent: 15,
                          ),
                        )
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
        backgroundColor: const Color.fromRGBO(27, 150, 241, 1.0),
        onPressed: () {
          Get.bottomSheet(
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  TextField(
                    controller: homePageController.contactController.value,
                    decoration: const InputDecoration(
                      labelText: 'Add contact',
                      hintText: 'Add someone to your contact',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      onPressed: () async {
                        await homePageController.addContacts(context);
                      },
                      child: const Icon(Icons.add_call),
                    ),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
          );
        },
        child: const Icon(Icons.message),
      ),
      drawer: DefaultDrawer(
        id: homePageController.id!,
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
