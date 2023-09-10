import 'package:chatapp/componenets/default%20drawer.dart';
import 'package:chatapp/core/utils/constants.dart';
import 'package:chatapp/core/utils/user%20data.dart';
import 'package:chatapp/core/widgets/custom%20text%20field.dart';
import 'package:chatapp/core/widgets/loading%20state.dart';
import 'package:chatapp/features/home%20screen/presentation/views/widgets/home%20body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../../../../controllers/home page controller.dart';
import '../../../../models/contacts.dart';
import '../controller/home page controller.dart';

// import '../componenets/default drawer.dart';
// import '../controllers/home page controller.dart';
// import '../models/contacts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    HomePageController homePageController = Get.put(HomePageController(id: getIt.get<String>()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rawabet'),
        centerTitle: true,
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