enum HttpMethod { GET, POST, DELETE }

//基础请求
abstract class BaseRequest {
  // curl -X GET "http://xxxx/test?requestParams=11" -H "accept: */*"
  // curl -X GET "https://xxxx/test/11" -H "accept: */*"

  var pathParams;
  var useHttps = true;

  //域名
  String authority() {
    return "www.badiu.com";
  }

  HttpMethod httpMethod();

  //请求路径
  String path();

  //拼接url
  String url() {
    Uri uri;
    var pathStr = path();
    //拼接path参数
    if (pathStr.endsWith("/")) {
      pathStr = "${path()}$pathParams";
    } else {
      pathStr = "${path()}/$pathParams";
    }
    //http,https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print('uri:${uri.toString()}');
    return uri.toString();
  }

  // 是否需要登录
  bool needLogin();

  //参数map
  Map<String, String> params = Map();

  /// 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = Map();

  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
