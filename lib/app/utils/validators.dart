import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';

class Validator {
  static final Validator _singleton = Validator._internal();

  factory Validator() {
    return _singleton;
  }

  Validator._internal();

  static Validator get instance => _singleton;

  var error = "";

  bool signUpValidator(
    String email,
    String password,
    String confPassword,
    bool isCheckedTermAndCondition,
  ) {
    if (email.isEmpty) {
      error = "Please enter email";
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email.trim())) {
      error = "Please enter valid email";
      return false;
    } else if (password.isEmpty) {
      error = "Please enter password";
      return false;
    } else if (password.trim().length < 8) {
      error = "Password must be 8 Characters long";
      return false;
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(password.trim())) {
      error = 'Password must contain at least one uppercase letter';
      return false;
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(password.trim())) {
      error = 'Password must contain at least one lowercase letter';
      return false;
    } else if (!RegExp(r'(?=.*?\d)').hasMatch(password.trim())) {
      error = 'Password must contain at least one digit';
      return false;
    } else if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(password.trim())) {
      error = 'Password must contain at least one special character (!@#\$&*~)';
      return false;
    } else if (confPassword.isEmpty) {
      error = "Confirm password is Required";
      return false;
    } else if (password != confPassword) {
      error = "confirm password is not matched";
      return false;
    } else if (isCheckedTermAndCondition == false) {
      error = "please accept terms & conditions";
      return false;
    } else {
      return true;
    }
  }

  //==========login===//
  bool loginValidator(String email, String password) {
    if (email.trim().isEmpty) {
      error = "Please enter email";
      return false;
    } else if (!Utils.emailValidation(email.trim())) {
      error = "Please enter a valid email";
      return false;
    } else if (password.trim().isEmpty) {
      error = "Please enter password";
      return false;
    } else if (password.trim().length < 8) {
      error = "Password length should be minimum 8";
      return false;
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$')
        .hasMatch(password.trim())) {
      error =
          "Password should contain at least 1 alphabet, 1 number, and 1 special character";
      return false;
    } else {
      return true;
    }
  }

  //==========forgot passcode ===//
  bool forgotPasswordValidator(
    String email,
  ) {
    if (email.isEmpty) {
      error = "Please enter email";
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email.trim())) {
      error = "Please enter valid email";
      return false;
    } else {
      return true;
    }
  }

  //==========create group ===//
  bool createGroupValidator(
    String groupName,
    String groupIcon,
  ) {
    if (groupName.isEmpty) {
      error = "Please enter group name";
      return false;
    } else if (groupIcon.isEmpty) {
      error = "Please enter group image";
      return false;
    } else {
      return true;
    }
  }

  //==========verifcation otp ===//
  bool otpverificationValidator(
    String otp,
  ) {
    if (otp.isEmpty) {
      error = "Please enter email";
      return false;
    } else {
      return true;
    }
  }

  //==========contact US  ===//
  bool contactUsValidator(
    String email,
    String subject,
    String message,
  ) {
    if (email.isEmpty) {
      error = "Please enter your email ";
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email.trim())) {
      error = "Please enter valid email";
      return false;
    } else if (subject.isEmpty) {
      error = "Please enter your Subject";
      return false;
    } else if (message.isEmpty) {
      error = "Please enter your Message ";
      return false;
    } else {
      return true;
    }
  }

  //========create password ===//
  bool createPsswordValidator(
    String password,
    String confrimPassword,
  ) {
    if (password.isEmpty) {
      error = "Please enter password";
      return false;
    } else if (password.length > 15) {
      error = "Password maximum length 15 character";
      return false;
    } else if (password.trim().length < 6) {
      error = "Password must be 8 Characters long";
      return false;
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(password.trim())) {
      error = 'Password must contain at least one uppercase letter';
      return false;
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(password.trim())) {
      error = 'Password must contain at least one lowercase letter';
      return false;
    } else if (!RegExp(r'(?=.*?\d)').hasMatch(password.trim())) {
      error = 'Password must contain at least one digit';
      return false;
    } else if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(password.trim())) {
      error = 'Password must contain at least one special character (!@#\$&*~)';
      return false;
    } else if (confrimPassword.isEmpty) {
      error = "Please enter Confrim password";
      return false;
    } else if (password != confrimPassword) {
      error = "confirm password is not matched";
      return false;
    } else {
      return true;
    }
  }

  bool changePasswordValidator({
    required String newPassword,
    required String confirmPassword,
  }) {
    if (newPassword.isEmpty) {
      error = "Please enter your New Password";
      return false;
    } else if (newPassword.length > 15) {
      error = "Password maximum length 15 character";
      return false;
    } else if (newPassword.trim().length < 6) {
      error = "Password must be 8 Characters long";
      return false;
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(newPassword.trim())) {
      error = 'Password must contain at least one uppercase letter';
      return false;
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(newPassword.trim())) {
      error = 'Password must contain at least one lowercase letter';
      return false;
    } else if (!RegExp(r'(?=.*?\d)').hasMatch(newPassword.trim())) {
      error = 'Password must contain at least one digit';
      return false;
    } else if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(newPassword.trim())) {
      error = 'Password must contain at least one special character (!@#\$&*~)';
      return false;
    } else if (confirmPassword.isEmpty) {
      error = "Please enter your Confirm Password ";
      return false;
    } else if (newPassword != confirmPassword) {
      error = "Confirm Password is not match";
      return false;
    } else {
      return true;
    }
  }

  //==========create nanny Profile ===//
  bool createNannyProfileValidator({
    required String image,
    required String firstname,
    required String lastName,
    required String experience,
    required String highSchoolName,
    required String phoneNumber,
    required String collegeName,
    required String age,
    required String location,
    required String aboutYourSelf,
  }) {
    if (image.isEmpty) {
      error = "Please add your image";
      return false;
    } else if (firstname.isEmpty) {
      error = "Please enter your first name ";
      return false;
    } else if (lastName.isEmpty) {
      error = "Please enter your last name";
      return false;
    } else if (age.isEmpty) {
      error = "Please enter your age";
      return false;
    } else if (phoneNumber.isEmpty) {
      error = "Please enter your phone number";
      return false;
    } else if (location.isEmpty) {
      error = "Please select your location ";
      return false;
    } else if (experience.isEmpty) {
      error = "Please enter your experience";
      return false;
    } else if (highSchoolName.isEmpty) {
      error = "Please enter your high school name";
      return false;
    } else if (collegeName.isEmpty) {
      error = "Please enter your college name";
      return false;
    } else if (aboutYourSelf.isEmpty) {
      error = "Please tell us about yourself";
      return false;
    } else {
      return true;
    }
  }

  /// select services validator
  services({required List<dynamic> servicesList}) {
    if (servicesList.isEmpty) {
      error = 'Please choose at least one service';
      return false;
    } else {
      return true;
    }
  }

  /// bank detail validator.
  bankDetailValidator({
    required String bankName,
    required String accountHolderName,
    required String accountNumber,
    required String routingNumber,
  }) {
    if (bankName.isEmpty) {
      error = 'Please enter your bank name';
      return false;
    } else if (accountHolderName.isEmpty) {
      error = 'Please enter your  account name';
      return false;
    } else if (accountNumber.isEmpty) {
      error = 'Please enter your  account number';
      return false;
    } else if (routingNumber.isEmpty) {
      error = 'Please enter your  routing number';
      return false;
    } else {
      return true;
    }
  }

  /// * CREATE CUSTOMER PROFILE VALIDATORS---------------->>>>>>>>>>>>>>.
  bool customerCreateProfileValidator({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? coordinates,
  }) {
    if (firstName!.isEmpty) {
      error = "Please enter First Name";
      return false;
    } else if (lastName!.isEmpty) {
      error = "Please enter Last Name";
      return false;
    } else if (phoneNumber!.isEmpty) {
      error = "Please enter Phone Number";
      return false;
    } else if (coordinates!.isEmpty) {
      error = "Please Select Your Location";
      return false;
    } else {
      return true;
    }
  }

  /// add availability validator
  addNannyAvailabilityValidator(
      {required TimeOfDay? startTime, required TimeOfDay? endTime}) {
    if (startTime == null) {
      error = "Please Select Start Time";
      return false;
    } else if (endTime == null) {
      error = "Please Select End Time";
      return false;
    } else if (endTime.hour < startTime.hour ||
        (endTime.hour == startTime.hour &&
            endTime.minute <= startTime.minute)) {
      error = "End time should be after start time";
      return false;
    } else {
      return true;
    }
  }
}
