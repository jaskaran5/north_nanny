import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyProfileController extends GetxController {
  String userName = 'Michael Johnson';
  String userEmail = 'example@gmail.com';
  String imageUrl =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cGVyc29ufGVufDB8fDB8fHww';
  String userAddress = 'Chicago, Naperville';
  String userPhoneNumber = '+1-773 856 9258';
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();

  @override
  void onInit() {
    editProfileInit();
    super.onInit();
  }

  editProfileInit() {
    firstNameTextEditingController.text = 'Michael';
    lastNameTextEditingController.text = 'Johnson';
    phoneNumberTextEditingController.text = '+1-773 856 9258';
    locationTextEditingController.text = 'Chicago, Naperville';
    update();
  }
}
