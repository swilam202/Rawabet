
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../componenets/custom text field.dart';
import '../../controller/auth controller.dart';

class TextFieldSection extends StatelessWidget {
   TextFieldSection({super.key,});


  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    return Column(
      children: [

        controller.isLogin.value == false
            ? CustomTextField(
          labelText: 'Name',
          valid: (data) {
            if (data!.length < 3 || data.length > 20)
              return 'Name must be more than 2 characters and less than 20';
            else
              return null;
          },
          hintText: 'enter name here',
          icon: const Icon(Icons.person),
          controller: controller.nameController.value,
        )
            : const SizedBox(),
        CustomTextField(
          labelText: 'Email',
          hintText: 'enter email here',
          icon: const Icon(Icons.alternate_email),
          controller: controller.emailController.value,
          valid: (data) {
            if (!data!.contains('@'))
              return 'invalid email';
            else
              return null;
          },
        ),
        CustomTextField(
          labelText: 'Password',
          hintText: 'enter password here',
          icon: IconButton(
            onPressed: () {
              controller.secure.value = !controller.secure.value;
            },
            icon: Icon(
              controller.secure.value
                  ? Icons.visibility
                  : Icons.visibility_off_rounded,
            ),
          ),
          controller: controller.passwordController.value,
          obscure: controller.secure.value,
          valid: (data) {
            if (data!.length <= 6)
              return 'password is too short';
            else
              return null;
          },
        ),
        controller.isLogin.value == false
            ? CustomTextField(
          labelText: 'Rewrite password',
          hintText: 'rewrite password here',
          icon: IconButton(
            onPressed: () {
              controller.secure.value = !controller.secure.value;
            },
            icon: Icon(
              controller.secure.value
                  ? Icons.visibility
                  : Icons.visibility_off_rounded,
            ),
          ),
          controller: controller.rewritePasswordController.value,
          obscure: controller.secure.value,
          valid: (data) {
            if (data != controller.passwordController.value.text)
              return 'password does not match';
            else
              return null;
          },
        )
            : const SizedBox(),

      ],
    );
  }
}
