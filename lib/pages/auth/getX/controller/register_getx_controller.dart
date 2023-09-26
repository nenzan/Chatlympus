import 'package:chatlympus/common/utils/constants.dart';
import 'package:chatlympus/pages/chats/page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterGetxController extends GetxController {
  final bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final email = emailController.text;
    final password = passwordController.text;
    final username = usernameController.text;
    try {
      await supabase.auth
          .signUp(email: email, password: password, data: {'username': username});
      Navigator.of(Get.context!)
          .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    } on AuthException catch (error) {
      Get.context!.showErrorSnackBar(message: error.message);
    } catch (error) {
      Get.context!.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }
}
