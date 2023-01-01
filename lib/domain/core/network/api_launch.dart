import 'package:dio/dio.dart';

import 'env.dart';

class ApiLaunch {
  Dio launch() {
    Dio dio = Dio();
    // dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     responseHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     request: true,
    //     error: true,
    //     compact: true,
    //     maxWidth: 1000));
    dio.options.baseUrl = AppConstants.baseEnvironment.baseUrl;
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['accept'] = 'application/json';
    dio.options.contentType = "application/x-www-form-urlencoded";
    // print("token auth ${box.read(TOKEN)}");
    dio.options.followRedirects = false;
    dio.options.validateStatus = (t) {
      return t! < 500;
    };

    dio.interceptors.add(Logging());

    return dio;
  }
}

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path} | QParam ${options.queryParameters} | Data => ${options.data.toString()}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
