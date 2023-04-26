import 'dart:convert';

import 'package:my_first_flutter_app/http/request/base_request.dart';

///网络请求抽象类
abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

///统一网络层返回格式
class HiNetResponse<T> {
  T? data;

  BaseRequest? request;

  int? statusCode; //http状态码

  String? statusMessage;

  dynamic extra; //其他动态的参数

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    } else {
      return data.toString();
    }
  }

  HiNetResponse(
      {this.data,
      this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});
}
