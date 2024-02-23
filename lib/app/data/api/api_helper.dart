import 'package:get/get.dart';

abstract class ApiHelper {
  static ApiHelper get to => Get.find();

  Future<Response> getPosts(url);
  Future<Response> postApi(url, body);
}
