import 'package:chatlympus/common/utils/constants.dart';
import 'package:chatlympus/pages/chats/page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationGetxController extends GetxController {
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> signIn() async {
    update();
    isLoading = true;

    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.of(Get.context!)
          .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    } on AuthException catch (error) {
      Get.context!.showErrorSnackBar(message: error.message);
    } catch (_) {
      Get.context!.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }
}
