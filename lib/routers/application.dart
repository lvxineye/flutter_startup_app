import 'package:fluro/fluro.dart';

enum ENV { DEV, TEST, BETA, PRODUCTION }

class Application {

  /// 通过application设置环境变量
  static ENV env = ENV.DEV;

  static bool pageIsOpen = true;

  static Router router;

  /// 所有获取配置的唯一入口
  Map<String, String> get config {
    if (ENV.PRODUCTION == Application.env) {
      return {};
    } else if (ENV.TEST == Application.env) {
      return {};
    } else if (ENV.BETA == Application.env) {
      return {};
    } else {
      return {};
    }
  }
}
