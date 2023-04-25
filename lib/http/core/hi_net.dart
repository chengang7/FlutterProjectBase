import 'package:my_first_flutter_app/http/core/hi_error.dart';
import 'package:my_first_flutter_app/http/core/hi_net_adapter.dart';
import 'package:my_first_flutter_app/http/request/base_request.dart';
import 'package:my_first_flutter_app/logger/hi_logger.dart';

class HiNet {
  HiNet._();

  static late HiNet _instance;

  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      logger.d(e.message);
    } catch (e) {
      //其它异常
      error = e;
      logger.e(e);
    }

    if (null == response) {
      logger.d(error);
    }
    var result = response('data');
    logger.d(result);
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    logger.d('url:${request.url()}');
    logger.d('method:${request.httpMethod()}');
    request.addHeader("token", "123");
    logger.d('header:${request.header}');
    return Future.value({
      "statusCode": 200,
      "data": {"code": 0, "message": "success"}
    });
  }
}
