import 'package:chatapp/controllers/login%20controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsOfUse extends StatelessWidget {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => ListView(
        children: [
          const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
          Row(
            children: [
              Checkbox(
                  value: controller.policiesCheck.value,
                  onChanged: (val) => controller.policiesCheck.value = val!),
              const Text(
                'Agree to terms of use',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Get back'),
          ),
        ],
      ),
    ));
  }
}
