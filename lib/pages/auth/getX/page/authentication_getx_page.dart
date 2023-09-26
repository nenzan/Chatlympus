import 'package:chatlympus/common/utils/constants.dart';
import 'package:chatlympus/pages/auth/getX/controller/authentication_getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationGetxPage extends StatelessWidget {
  const AuthenticationGetxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationGetxController>(
      init: AuthenticationGetxController(),
      builder: (AuthenticationGetxController controller) {
        return Scaffold(
          body: Scaffold(
            appBar: AppBar(title: const Text('Sign In')),
            body: ListView(
              padding: formPadding,
              children: [
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                formSpacer,
                TextFormField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                formSpacer,
                ElevatedButton(
                  onPressed: controller.isLoading ? null : controller.signIn,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
