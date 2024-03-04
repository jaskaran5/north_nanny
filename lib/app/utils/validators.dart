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
  ) {
    if (email.isEmpty) {
      error = "Please enter email";
      return false;
    } else if (password.isEmpty) {
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
    } else if (confPassword.isEmpty) {
      error = "Confirm password is Required";
      return false;
    } else if (password != confPassword) {
      error = "confirm password is not matched";
      return false;
    } else {
      return true;
    }
  }

  //==========login===//
  bool loginValidator(
    String email,
    String password,
  ) {
    if (email.trim().isEmpty) {
      error = "Please enter email";
      return false;
    } else if (!Utils.emailValidation(email.trim())) {
      error = "Please enter a valid email";
      return false;
    } else if (password.trim().isEmpty) {
      error = "Please enter password";
      return false;
    } else {
      return true;
    }
  }

  //==========foget passcode ===//
  bool forgetpasswordValidator(
    String email,
  ) {
    if (email.isEmpty) {
      error = "Please enter email";
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
    String name,
    String subject,
    String message,
  ) {
    if (name.isEmpty) {
      error = "Please enter your name ";
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

  bool changePasswrdValidator(
    String password,
    String newPassword,
    String confrimPassword,
  ) {
    if (password.isEmpty) {
      error = "Please enter your Password ";
      return false;
    } else if (newPassword.isEmpty) {
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
    } else if (confrimPassword.isEmpty) {
      error = "Please enter your Confrim Password ";
      return false;
    } else if (newPassword != confrimPassword) {
      error = "Confrim Password is not match";
      return false;
    } else {
      return true;
    }
  }

  //==========foget passcode ===//
  bool createProfileValidator(
    //     String image,
    String name,
    String ft,
    String inches,
    String username,
  ) {
/*if(image.isEmpty){
  error = "Plaese add your image";
  return false;
}
     else*/
    if (name.isEmpty) {
      error = "Please enter your name ";
      return false;
    } else if (ft.isEmpty) {
      error = "ft is empty";
      return false;
    } else if (inches.isEmpty) {
      error = "inches is empty";
      return false;
    } else if (username.isEmpty) {
      error = "username is empty";
      return false;
    } else {
      return true;
    }
  }
}
