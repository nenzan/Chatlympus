import 'package:chatlympus/pages/auth/getX/page/authentication_getx_page.dart';
import 'package:get/get.dart';

import 'route_constant.dart';

class AppRoute {
  static final all = [
    GetPage(name: RouteConstant.auth, page: () => const AuthenticationGetxPage()),
  ];
}
