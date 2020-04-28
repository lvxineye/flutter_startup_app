

import 'package:fluro/fluro.dart';
import 'package:startupapp/routers/router_handler.dart';

class Routes {

  static String root = '/';
  static String loginPage = '/login_page';
  static String home = '/home';

  static void configureRoutes(Router router) {

    router.define(loginPage, handler: loginPageHandler);
    router.define(home, handler: homeHandler);
  }
}