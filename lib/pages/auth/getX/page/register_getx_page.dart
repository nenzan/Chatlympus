import 'package:chatlympus/pages/auth/getX/controller/register_getx_controller.dart';
import 'package:chatlympus/pages/auth/getX/page/authentication_getx_page.dart';
import 'package:flutter/material.dart';
import 'package:chatlympus/pages/chats/page/chat_page.dart';
import 'package:chatlympus/common/utils/constants.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.isRegistering}) : super(key: key);

  static Route<void> route({bool isRegistering = false}) {
    return MaterialPageRoute(
      builder: (context) => RegisterPage(isRegistering: isRegistering),
    );
  }

  final bool isRegistering;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterGetxController>(
        init: RegisterGetxController(),
        builder: (RegisterGetxController controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
            ),
            body: Form(
              key: controller.formKey,
              child: ListView(
                padding: formPadding,
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  formSpacer,
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      if (val.length < 6) {
                        return '6 characters minimum';
                      }
                      return null;
                    },
                  ),
                  formSpacer,
                  TextFormField(
                    controller: controller.usernameController,
                    decoration: const InputDecoration(
                      label: Text('Username'),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Required';
                      }
                      final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
                      if (!isValid) {
                        return '3-24 long with alphanumeric or underscore';
                      }
                      return null;
                    },
                  ),
                  formSpacer,
                  ElevatedButton(
                    onPressed: controller.isLoading ? null : controller.signUp,
                    child: const Text('Register'),
                  ),
                  formSpacer,
                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).push(AuthenticationGetxPage.route());
                      Get.to(GetPage(
                          name: '/auth',
                          page: () => const AuthenticationGetxPage()));
                    },
                    child: const Text('I already have an account'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
