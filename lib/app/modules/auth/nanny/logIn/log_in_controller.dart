import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/models/customer_login_response_model.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';
import 'package:northshore_nanny_flutter/app/utils/validators.dart';
import 'package:northshore_nanny_flutter/navigators/routes_management.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../data/api/api_helper.dart';
import '../../../../models/login_response_model.dart';
import '../../../../res/constants/app_constants.dart';
import '../../../../res/constants/enums.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/utility.dart';
import '../../../common/socket/singnal_r_socket.dart';

class LogInController extends GetxController {
  final ApiHelper _apiHelper = ApiHelper.to;
  String loginType = '';

  bool isPasswordVisible = true;
  RxBool rememberMe = false.obs;

  @override
  void onInit() {
    checkLoginType();
    super.onInit();
    checkSavedSession();
  }

  checkAndRemoveAuthToken() {
    if (Storage.hasData(StringConstants.token)) {
      log("has token-----");
      Storage.removeValue(StringConstants.token);
    } else {
      log("doesnt have auth token======");
    }
  }

  /// SAVE REMEMBER ME DATA
  saveRememberMeValue() {
    if (rememberMe.value) {
      Storage.saveValue(
          StringConstants.email, emailTextEditingController.text.trim());
      Storage.saveValue(
          StringConstants.pswd, passwordTextEditingController.text.trim());
    } else {
      Storage.removeValue(
        StringConstants.email,
      );
      Storage.removeValue(StringConstants.pswd);
    }
  }

  checkSavedSession() {
    if (Storage.hasData(StringConstants.email)) {
      rememberMe.value = true;
      emailTextEditingController.text = Storage.getValue(StringConstants.email);
      passwordTextEditingController.text =
          Storage.getValue(StringConstants.pswd);
      update();
    }
  }

  /// check user Type.
  checkLoginType() {
    loginType = Storage.getValue(StringConstants.loginType);

    update();
  }

  /// ---------- TOOGLE  PASSWORD----------
  togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  /// ---------- TOOGLE  REMEMBER ME----------
  toggleRememberMe({val}) {
    rememberMe.value = val;
    update();
  }

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  /// to check remember me enable or disable.
  bool? isRememberMe = false;

  /// log in validation.
  Future<void> onClickOnLogin() async {
    bool valid = Validator.instance.loginValidator(
        emailTextEditingController.text.trim(),
        passwordTextEditingController.text.trim());

    if (valid) {
      if (loginType == StringConstants.customer) {
        await loginApi(userType: 1);
      } else {
        await loginApi(userType: 2);
      }
    } else {
      toast(msg: Validator.instance.error, isError: true);
    }
  }

  /// log in api for nanny and customer.
  loginApi({required int userType}) async {
    if (Storage.hasData(StringConstants.token)) {
      Storage.removeValue(StringConstants.token);
    }
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
      log("fcm token : $deviceToken");

      if (!(await Utils.hasNetwork())) {
        return;
      }
      var timeZone = await Utility.getTimeZone();

      var body = {
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
        "deviceToken": deviceToken,
        "deviceType": Platform.isAndroid ? "android" : "ios",
        "userType": userType,
        'timeZone': timeZone,
        // "latitude":
        //     Storage.getValue(StringConstants.latitude) ?? 30.7046.toString(),
        // "longitude":
        //     Storage.getValue(StringConstants.longitude) ?? 76.7179.toString(),
      };

      printInfo(info: "login up controller form data: $body");

      _apiHelper.postApi(ApiUrls.customerLogin, body).futureValue(
          (value) async {
        saveRememberMeValue();
        if (userType == 2) {
          /******* NANNY ----------->>>>>>>> */
          var res = LoginResponseDataModel.fromJson(value);
          if (res.response == AppConstants.apiResponseSuccess) {
            Storage.saveValue(StringConstants.userId, res.data?.user!.id);

            Storage.saveValue(StringConstants.token, res.data?.token);

            await Storage.removeValue(StringConstants.inviteAFriendCode);
            Storage.saveValue(
                StringConstants.inviteAFriendCode, res.data?.user?.couponCode);
            if (res.data?.user?.isProfileCreated == false) {
              RouteManagement.goToCreateNannyProfile();
            } else if (res.data?.user?.isServicesCreated == false) {
              RouteManagement.goToSelectServicesView();
            } else if (res.data?.user?.isBankDetailAdded == false &&
                res.data?.user?.isSkipBankDetail == false) {
              RouteManagement.goToBankDetailView();
            }
            // else if (res.data?.user?.isApproved == false ||
            //     res.data?.user?.isSkipBankDetail == true) {
            //   RouteManagement.goToOffAllWaitingApprovalView();
            // }
            else {
              Storage.saveValue(StringConstants.isLogin, true);

              RouteManagement.goToOffAllDashboard(isFromSetting: false);
            }
            toast(msg: res.message.toString(), isError: false);
          } else {
            toast(msg: res.message.toString(), isError: true);
          }
        } else if (userType == 1) {
          /******* CUSTOMER ----------->>>>>>>> */
          var res = CustomerLoginResponseModel.fromJson(value);

          log("login response : $res");

          if (res.response == AppConstants.apiResponseSuccess) {
            Storage.saveValue(StringConstants.userId, res.data!.user!.id);

            Storage.saveValue(StringConstants.token, res.data?.token);
            await Storage.removeValue(StringConstants.inviteAFriendCode);
            Storage.saveValue(
                StringConstants.inviteAFriendCode, res.data?.user?.couponCode);
            if (res.data?.user?.isProfileCreated == false) {
              /** PROFILE is not created */

              RouteManagement.goToCreateCustomerProfile();
            } else {
              if (res.data?.user?.isSkipChildDetails == true) {
                Storage.saveValue(StringConstants.isLogin, true);
                RouteManagement.goToOffAllDashboard(isFromSetting: false);
              } else if (res.data?.user?.isChildAdded == false) {
                RouteManagement.goToChooseChildProfileView();
              } else if (res.data?.user?.isChildAdded == true) {
                Storage.saveValue(StringConstants.isLogin, true);
                RouteManagement.goToOffAllDashboard(isFromSetting: false);
              }
            }
          } else {
            toast(msg: res.message!, isError: true);
          }
        }
        SignalRHelper().init();
      }, onError: (error) {
        toast(msg: error.toString(), isError: true);
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      log("LogIn Api have some issue please check $s ");
    }
  }

  /// used to store apple  , facebook and instagram credentials to firebase.
  final auth = FirebaseAuth.instance;

  /// used to store credentials for apple log in.
  final flutterSecureStorage = const FlutterSecureStorage();

  /// used to login or signup with social login.
  Future<void> socialLogInOrSignup({
    required String email,
    required String authorizationId,
    required SocialLoginType logInMode,
  }) async {
    final deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
    log("fcm token : $deviceToken");
    var timeZone = await Utility.getTimeZone();
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }

      /// user type one is for customer .

      var body = {
        "email": email,
        // "password": "",
        "userType": 1,
        "deviceToken": deviceToken,
        "deviceType": Platform.isAndroid ? 'android' : 'ios',
        "timeZone": timeZone,
        "authorizationId": authorizationId,
        "mode": logInMode.name,
      };
      log('--->>>>>>>>>>>>>> Social login or signup Body:${body.toString()}');
      _apiHelper.postApi(ApiUrls.customerSignup, body).futureValue((value) {
        var res = CustomerLoginResponseModel.fromJson(value);
        if (res.response == AppConstants.apiResponseSuccess) {
          Storage.saveValue(StringConstants.token, res.data!.token);
          Storage.saveValue(StringConstants.userId, res.data?.user!.id);
          toast(msg: res.message!, isError: false);
          if (res.data?.user?.isProfileCreated == false) {
            /** PROFILE is not created */
            RouteManagement.goToCreateCustomerProfile();
          } else if (res.data?.user?.isSkipChildDetails == true) {
            Storage.saveValue(StringConstants.isLogin, true);
            RouteManagement.goToOffAllDashboard(isFromSetting: false);
          } else if (res.data?.user?.isChildAdded == false) {
            RouteManagement.goToChooseChildProfileView();
          } else if (res.data?.user?.isChildAdded == true) {
            Storage.saveValue(StringConstants.isLogin, true);
            RouteManagement.goToOffAllDashboard(isFromSetting: false);
          }
        } else {
          toast(msg: res.message.toString(), isError: true);
        }
      }, onError: (error) {
        toast(msg: error!, isError: true);
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      log("Social Api have some issue please check $s ");
    }
  }

  /// used to signup With Apple.
  void signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
      );
      if (credential.email == null || credential.email == '') {
        var value = await flutterSecureStorage.read(
            key: "${credential.userIdentifier}");
        if (value != null) {
          // String name = value.split('/')[0];
          // String familyName = value.split('/')[2];
          String email = value.split('/')[1];
          auth.signInWithCredential(oauthCredential).then((value) {
            log("firebase apple login value: $value");

            /// social log in api
            socialLogInOrSignup(
              email: email,
              authorizationId: value.user!.uid,
              logInMode: SocialLoginType.apple,
            );
          });
        } else {
          // String name = credential.givenName ?? "";
          // String familyName = credential.familyName ?? "";
          String email = credential.email ?? "";

          /// store apple credentials in firebase.
          auth.signInWithCredential(oauthCredential).then((value) {
            log("firebase apple login value: $value");
            socialLogInOrSignup(
              email: email,
              authorizationId: value.user!.uid,
              logInMode: SocialLoginType.apple,
            );
          });
        }
      } else {
        await flutterSecureStorage.write(
            key: credential.userIdentifier.toString(),
            value:
                "${credential.givenName}/${credential.email}/${credential.familyName}");
        auth.signInWithCredential(oauthCredential).then((value) {
          log("firebase apple login value: $value");
          socialLogInOrSignup(
            email: credential.email.toString(),
            authorizationId: value.user!.uid,
            logInMode: SocialLoginType.apple,
          );
        });
      }
    } catch (e) {
      toast(msg: e.toString(), isError: true);
      printError(info: e.toString());
    }
  }

  /// used to log in with facebook.
  Future<void> facebookLogin() async {
    final res = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
      //loginBehavior: LoginBehavior.dialogOnly,
    );
    //final LoginResult res = await FacebookAuth.instance.login();

    switch (res.status) {
      case LoginStatus.success:
        final accessToken = res.accessToken;
        debugPrint('Access token facebook: ${accessToken?.token}');
        if (accessToken?.token == null) {
          return;
        }
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        Map<String, dynamic> userData = await FacebookAuth.instance.getUserData(
          fields: "email,name,picture.width(200)",
        );
        await auth.signInWithCredential(facebookAuthCredential).then((value) {
          printInfo(
              info:
                  'facebook data from firebase>>>>>>>> ${userData.toString()}');
          final imageUrl = userData["picture"];
          final name = userData["name"];
          final userId = userData["id"];
          final email = userData["email"];
          if (email != null) {
            debugPrint('And your facebook email is $email');
          }
          debugPrint('Your facebook profile image: $imageUrl');
          debugPrint('Your facebook profile Name: $name');
          debugPrint('Your facebook profile userId: $userId');
          // String? fullName = name ?? "";
          // var names = fullName!.split(' ');
          // var firstName = names[0];
          // var lastName = names[1];
          // var image = imageUrl;
          var userEmail = email;
          var id = userId;

          socialLogInOrSignup(
              email: userEmail.toString(),
              authorizationId: id.toString(),
              logInMode: SocialLoginType.facebook);
        });
        break;

      case LoginStatus.cancelled:
        toast(msg: res.message.toString(), isError: true);
        break;
      case LoginStatus.failed:
        debugPrint('Error while log in: ${res.message}');
        toast(msg: res.message.toString(), isError: true);
        break;
      case LoginStatus.operationInProgress:
        const CircularProgressIndicator();
        break;
    }
  }
}
