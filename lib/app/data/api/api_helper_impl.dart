import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'api_helper.dart';

class ApiHelperImpl extends GetConnect implements ApiHelper {
  @override
  void onInit() {
    httpClient.baseUrl = ApiUrls.baseUrl;
    httpClient.timeout = StringConstants.timeout;

    addRequestModifier();

    httpClient.addResponseModifier((request, response) {
      printInfo(
        info: 'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.toString() ?? ''}',
      );

      return response;
    });
  }

  void addRequestModifier() {
    Utils.hasNetwork();
    httpClient.addRequestModifier<dynamic>((request) {
      if (Storage.hasData(StringConstants.token)) {
        printInfo(
            info: "auth token:-->> ${Storage.getValue(StringConstants.token)}");
        request.headers['Authorization'] =
            'Bearer ${Storage.getValue(StringConstants.token)}';
      }

      printInfo(
        info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );

      log(
        'REQUEST ║ ${request.method.toUpperCase()}\n'
        'url: ${request.url}\n'
        'Headers: ${request.headers}\n'
        'Body: ${request.files?.toString() ?? ''}\n',
      );

      return request;
    });
  }

  @override
  Future<Response<dynamic>> getPosts(url) => get(url);

  @override
  Future<Response<dynamic>> postApi(url, body) => post(url, body);
}
