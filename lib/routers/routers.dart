import 'package:fluro/fluro.dart';
import 'package:startupapp/routers/router_handler.dart';

class Routes {
  static String root = '/';
  static String loginPage = '/login-page';
  static String home = '/home';
  static String issuesMessagePage = '/issues-message-page';
  static String webViewPage = '/web-view-page';

  static void configureRoutes(Router router) {
    router.define(loginPage, handler: loginPageHandler);
    router.define(home, handler: homeHandler);
    router.define(issuesMessagePage, handler: issuesMessageHandler);
    router.define(webViewPage, handler: webViewPageHandler);
  }
}
