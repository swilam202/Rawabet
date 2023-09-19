import 'package:chatapp/componenets/default%20drawer.dart';
import 'package:chatapp/core/utils/constants.dart';
import 'package:chatapp/core/utils/notifications%20services.dart';
import 'package:chatapp/core/utils/user%20data.dart';
import 'package:chatapp/core/widgets/custom%20text%20field.dart';
import 'package:chatapp/core/widgets/loading%20state.dart';
import 'package:chatapp/features/home%20screen/presentation/views/widgets/home%20body.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../../../../controllers/home page controller.dart';
import '../../../../models/contacts.dart';
import '../controller/home page controller.dart';

// import '../componenets/default drawer.dart';
// import '../controllers/home page controller.dart';
// import '../models/contacts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
            FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
});
          
  }


  @override
  Widget build(BuildContext context) {

    

    HomePageController homePageController = Get.put(HomePageController(id:  UserData.getData('id'),));

   //const admin = require('firebase-admin');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rawabet'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()async{
            FirebaseMessaging messaging = FirebaseMessaging.instance;
            
    print('+++++++++++++++++++++++++++++++++++++++++++++++++');
    print(await messaging.getToken());
    print('+++++++++++++++++++++++++++++++++++++++++++++++++');
          }, icon: Icon(Icons.add),),
         /* IconButton(onPressed: ()async{
            NotificationsServices.sendNotification();
            setState(() {
              
            });
            FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
});
          }, icon: Icon(Icons.search),),*/
          IconButton(onPressed: (){
            print('+++++++++++++++++++++++id++++++++++++++++++++++++++++++');
            print(UserData.getData('id'));  
            print('+++++++++++++++++++++++id++++++++++++++++++++++++++++++');

          }, icon: Icon(Icons.delete),),
        ],
      ),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kLightColor,
        onPressed: () {
         homePageController.addContactBottomSheet(context);
        },
        child: const Icon(Icons.message),
      ),
      drawer: DefaultDrawer(),
    );
  }
}
