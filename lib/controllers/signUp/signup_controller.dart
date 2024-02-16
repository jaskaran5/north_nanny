import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/view_models/sign_up_view_model.dart';

class SignupViewController extends GetxController {
  SignupViewController(this.signUpViewModel);

  final SignUpViewModel signUpViewModel;

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final noOfChildrenTextEditingController = TextEditingController();
  final childNameTextEditingController = TextEditingController();
  final childAgeTextEditingController = TextEditingController();
  final allergiesTextEditingController = TextEditingController();
  final medicalConditionTextEditingController = TextEditingController();
  final anyThingTextEditingController = TextEditingController();

  /// check box true or false.
  bool? isBoxChecked = false;

  /// gender list.
  List<String> genderList = [
    TranslationKeys.male.capitalizeFirst.toString(),
    TranslationKeys.female.capitalizeFirst.toString()
  ];

  /// open gender dropDown,
  bool? showGenderDropDown = false;

  /// selected Gender
  String? selectedGender = '';

  /// storeGenderValue
  void setGenderValue(String gender) {
    selectedGender = gender;
    update();
  }

  /// method used to pick the Image from gallery
  // pickImageFromGallery() async {
  //   XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   if (image != null) {
  //     log("check image is not null -->$editPickedImage");
  //     var file = File(image.path);
  //     editPickedImage = file.path;
  //     update();
  //     log("check image is -->$editPickedImage");
  //   } else {
  //     log("check image is  null -->$editPickedImage");
  //   }
  // }
}
