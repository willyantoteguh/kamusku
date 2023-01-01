import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../domain/core/network/api_launch.dart';
import '../../../../domain/core/network/env.dart';

class DictionaryRemoteSource {
  final Dio _api = ApiLaunch().launch();

  Future<dynamic> getDefinitions(String query) async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      Response response = await _api.get("${AppConstants.baseEnvironment.baseUrl}$query");

      return response;
    } on DioError catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
