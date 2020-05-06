import 'package:fluro/fluro.dart';
import 'package:startupapp/api/Api.dart';
import 'package:startupapp/routers/application.dart';
import 'package:startupapp/routers/routers.dart';

import 'net_utils.dart';

class DataUtils {
  // 意见反馈
  static Future feedback(context, Map<String, String> params) async {
    var response = await NetUtils.post(Api.FEEDBACK, params);
    if (response['status'] == 401 && response['message'] == '请先登录') {
      Application.router.navigateTo(
        context,
        '${Routes.loginPage}',
        transition: TransitionType.nativeModal,
      );
    }
    return response['success'];
  }
}
