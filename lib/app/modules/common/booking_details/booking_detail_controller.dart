import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/data/api/api_helper.dart';
import 'package:northshore_nanny_flutter/app/models/booking_data_by_date_response_model.dart';
import 'package:northshore_nanny_flutter/app/models/tracking_response_model.dart';
import 'package:northshore_nanny_flutter/app/modules/common/socket/singnal_r_socket.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/app_constants.dart';
import 'package:northshore_nanny_flutter/app/res/constants/extensions.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:northshore_nanny_flutter/app/utils/custom_toast.dart';

import '../../../../navigators/routes_management.dart';
import '../../../models/booking_status_model.dart';
import '../../../res/constants/assets.dart';
import '../../../res/constants/enums.dart';
import '../../../res/theme/colors.dart';
import '../../../res/theme/styles.dart';
import '../../../utils/translations/translation_keys.dart';
import '../../../utils/utility.dart';
import '../rating_and_review/rating_and_review_binding.dart';
import '../rating_and_review/rating_and_review_controller.dart';
import '../send_tip_view/send_tip_view.dart';

class BookingDetailController extends GetxController {
  bool isExpandChildren = false;
  final ApiHelper _apiHelper = ApiHelper.to;

  /// used to initialize socket.
  SignalRHelper socket = SignalRHelper();

  /// used to store the booking detail data.
  BookingDataById? bookingDataById;

  /// used to show timer
  Timer? timer;
  int seconds = 0;
  Polyline? customerPolyLine;

  /// used to show the start time.
  showTimer({required DateTime startTime}) {
    log('Timer data $startTime');
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds = DateTime.now().difference(startTime).inSeconds;
      update(['customerTimerView']);
    });
  }

  int totalPrice = 0;

  /// used to show  send tip text Editing Controller.
  final sendTipAmountTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    seconds = 0;
    timer?.cancel();
  }

  /// check status
  BookingDetailStatus? bookingDetailStatus;

  /// api used to store the booking detail.
  getBookingDataById({required int bookingId}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        'currentUtcTime': DateTime.now().toUtc().toIso8601String(),
        "bookingId": bookingId,
      };
      log('body of get booking details data by id :$body');
      _apiHelper
          .postApi(ApiUrls.bookingDetailsById, jsonEncode(body))
          .futureValue((value) {
        printInfo(info: "get  CUSTOMER booking single data   $value");
        var response = BookingDataByIdResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          bookingDataById = response.data;
          addPolyLine(
              trackerLocationModel: trackerLocationModel,
              bookingDataById: response.data);
          update();
          if (response.data?.startTime != null &&
              response.data?.bookingStatus == 5) {
            seconds = 0;
            showTimer(
                startTime: bookingDataById?.startTime != null
                    ? DateTime.now().add(Duration(
                        seconds: Utility.calculateDifferenceInSeconds(
                            response.data?.startTime ?? DateTime.now())))
                    : DateTime.now());
          }
          if (response.data?.bookingStatus == 6) {
            timer?.cancel();
            seconds = 0;
            update(['customerTimerView']);
            Utility.showAlertDialog(
              title: 'Congratulations',
              firstButtonTitle: 'No',
              secondButtonTitle: 'Yes',
              onTapFirstButton: () {
                /// Reject  the nanny booking complete request
                updateStatus(
                  bookingId: response.data?.bookingId ?? 0,
                  bookingStatus: 8,
                );
              },
              onTapSecondButton: () {
                /// accept the nanny booking complete request
                updateStatus(
                  bookingId: response.data?.bookingId ?? 0,
                  bookingStatus: 7,
                );
              },
              firstButtonBackgroundColor: AppColors.lightNavyBlue,
              message:
                  'Your nanny has marked this job as complete, please confirm that the job was completed successfully.',
              secondButtonSvg: Assets.iconsStar,
              showButtonSvg: true,
              firstButtonStyle: AppStyles.ubNavyBlue14W700,
              secondButtonBackgroundColor: AppColors.navyBlue,
              secondButtonStyle: AppStyles.ubWhite14700,
            );
          }
          if (response.data?.bookingStatus == 7 &&
              response.data?.isSendTip == false &&
              response.data?.reviewGivenByMe == null) {
            Utility.showAlertDialog(
              title: 'Congratulations',
              firstButtonTitle: 'Send Tip',
              onTapFirstButton: () {
                Get.to(
                  () => SendTipView(
                      userName:
                          '${bookingDataById?.userDetails?.name ?? ''}${bookingDataById?.userDetails?.gender == 1 ? ', M' : bookingDataById?.userDetails?.gender == 2 ? ', F' : ''}',
                      image: bookingDataById?.userDetails?.image ?? '',
                      amountTextEditingController:
                          sendTipAmountTextEditingController,
                      onTapSubmitButton: () {
                        RouteManagement.goToCustomPaymentView(
                            isComeFromSendTip: true,
                            isComeFromConfirmBooking: false,
                            isCardAdded:
                                bookingDataById?.isCardAddedByCustomer ?? false,
                            onTapSubmit: () {
                              /// here to write the code send tip .
                              sendTip(
                                  amount:
                                      sendTipAmountTextEditingController.text,
                                  bookingId: bookingDataById?.bookingId ?? 0);
                            });

                        // RouteManagement.goToCustomPaymentView(
                        //     paymentDetails: cardList,
                        //     appBarTitle: ,
                        //     addNewCardButtonTitle: 'Add New Card',
                        //     addNewCardButtonBackgroundColor:
                        //         AppColors.lightNavyBlue,
                        //     onTapDeleteButton: () {},
                        //     submitButtonTitle: TranslationKeys.submit.tr,
                        //     submitButtonBackgroundColor: AppColors.navyBlue,
                        //     addNewCardButtonStyle: AppStyles.ubNavyBlue15W600,
                        //     onTapAddNewCardButton: () {
                        //       RouteManagement.goToAddPaymentMethodScreen(
                        //         isComeFromNannyProfile: false,
                        //         buttonText: TranslationKeys.submit.tr,
                        //         onTapButton: () {
                        //           Get.back();
                        //         },
                        //       );
                        //     },
                        //     onTapSubmitButton: () {
                        //       RouteManagement.goToSuccessView(
                        //         buttonText: TranslationKeys.backToHome.tr,
                        //         successSvg: '',
                        //         header: TranslationKeys.thankYou.tr,
                        //         subHeader:
                        //             TranslationKeys.yourNannyTipReceived.tr,
                        //         onTapButton: () {
                        //           RouteManagement.goToOffAllDashboard(
                        //               isFromSetting: false);
                        //         },
                        //         subTitleStyle: AppStyles.ubGrey16W500,
                        //         subHeaderMaxLines: 2,
                        //         headerMaxLines: 2,
                        //         successImage: Assets.imagesPinkHeart,
                        //         sendTipText: true,
                        //       );
                        //     },
                        //     showDeleteButton: false);
                      }),
                );
              },
              onTapSecondButton: () {
                /// used to going on review rating api
                Utility.closeDialog();
                if (!Get.isRegistered<RatingAndReviewController>()) {
                  RatingAndReviewBinding().dependencies();
                }
                Get.find<RatingAndReviewController>().storeUserData(
                  name: bookingDataById?.userDetails?.name ?? '',
                  image: bookingDataById?.userDetails?.image ?? '',
                  userReviews: bookingDataById?.userDetails?.reviewCount ?? 0,
                  toUserId: bookingDataById?.userDetails?.userId ?? 0,
                  bookedId: bookingDataById?.bookingId ?? 0,
                  userRating: bookingDataById?.userDetails?.rating ?? 0.0,
                  userGender: bookingDataById?.userDetails?.gender == 1
                      ? ', M'
                      : bookingDataById?.userDetails?.gender == 2
                          ? ', F'
                          : '',
                );
                RouteManagement.goToRatingReviewScreen();
              },
              secondButtonTitle: 'Rate Now',
              firstButtonBackgroundColor: AppColors.lightNavyBlue,
              firstButtonStyle: AppStyles.ubNavyBlue14W700,
              secondButtonBackgroundColor: AppColors.navyBlue,
              secondButtonStyle: AppStyles.ubWhite14700,
              imageName: Assets.imagesStar,
              showContentSvg: true,
              message:
                  'Your job has been successfully completed.Please rate your experience with this sitter',
            );
          }
          typeOfBooking(bookingStatus: response.data?.bookingStatus ?? 0);
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "CUSTOMER booking detail single Get  API ISSUE $s");
    }
  }

  /// method which is used to return the type of booking.
  typeOfBooking({required int bookingStatus}) {
    if (bookingStatus == 1) {
      bookingDetailStatus = BookingDetailStatus.booked;
    } else if (bookingStatus == 3) {
      bookingDetailStatus = BookingDetailStatus.rejected;
    } else if (bookingStatus == 5) {
      bookingDetailStatus = BookingDetailStatus.arrived;
    } else if (bookingStatus == 6) {
      seconds = 0;
      timer?.cancel();
      update(['customerTimerView']);
      update();
    } else if (bookingStatus == 8) {
      bookingDetailStatus = BookingDetailStatus.disputeRaised;
    } else if (bookingStatus == 9) {
      bookingDetailStatus = BookingDetailStatus.givenReviewByCustomer;
    } else if (bookingStatus == 10) {
      bookingDetailStatus = BookingDetailStatus.reviewByOtherUser;
    }
    log('Booking Status Customer Side :$bookingStatus');
    update();
  }

  /// update status
  updateStatus({
    required int bookingId,
    required int bookingStatus,
  }) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "bookingId": bookingId,
        "status": bookingStatus,
      };
      log('update status body -> $body');
      _apiHelper
          .postApi(
        ApiUrls.updateCustomerBookingStatus,
        jsonEncode(body),
      )
          .futureValue((value) {
        printInfo(info: "Update booking status $value");
        var response = BookingStatusModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          // /// used to show the alert dialog when the user mark as complete and reject the booking .
          // Utility.showAlertDialog(
          //   title: 'Congratulations',
          //   firstButtonTitle: 'No',
          //   secondButtonTitle: 'Yes',
          //   onTapFirstButton: () => Get.back(),
          //   onTapSecondButton: () {
          //     Utility.showAlertDialog(
          //       title: 'Congratulations',
          //       firstButtonTitle: 'Send Tip',
          //       onTapFirstButton: () {
          //         Get.to(
          //           () => SendTipView(
          //               userName: bookingDataById?.userDetails?.name ?? '',
          //               image: bookingDataById?.userDetails?.image ?? '',
          //               amountTextEditingController: TextEditingController(),
          //               onTapSubmitButton: () {
          //                 RouteManagement.goToCustomPaymentView(
          //                     isComeFromSendTip: true,
          //                     isComeFromConfirmBooking: false);
          //
          //                 // RouteManagement.goToCustomPaymentView(
          //                 //     paymentDetails: cardList,
          //                 //     appBarTitle: ,
          //                 //     addNewCardButtonTitle: 'Add New Card',
          //                 //     addNewCardButtonBackgroundColor:
          //                 //         AppColors.lightNavyBlue,
          //                 //     onTapDeleteButton: () {},
          //                 //     submitButtonTitle: TranslationKeys.submit.tr,
          //                 //     submitButtonBackgroundColor: AppColors.navyBlue,
          //                 //     addNewCardButtonStyle: AppStyles.ubNavyBlue15W600,
          //                 //     onTapAddNewCardButton: () {
          //                 //       RouteManagement.goToAddPaymentMethodScreen(
          //                 //         isComeFromNannyProfile: false,
          //                 //         buttonText: TranslationKeys.submit.tr,
          //                 //         onTapButton: () {
          //                 //           Get.back();
          //                 //         },
          //                 //       );
          //                 //     },
          //                 //     onTapSubmitButton: () {
          //                 //       RouteManagement.goToSuccessView(
          //                 //         buttonText: TranslationKeys.backToHome.tr,
          //                 //         successSvg: '',
          //                 //         header: TranslationKeys.thankYou.tr,
          //                 //         subHeader:
          //                 //             TranslationKeys.yourNannyTipReceived.tr,
          //                 //         onTapButton: () {
          //                 //           RouteManagement.goToOffAllDashboard(
          //                 //               isFromSetting: false);
          //                 //         },
          //                 //         subTitleStyle: AppStyles.ubGrey16W500,
          //                 //         subHeaderMaxLines: 2,
          //                 //         headerMaxLines: 2,
          //                 //         successImage: Assets.imagesPinkHeart,
          //                 //         sendTipText: true,
          //                 //       );
          //                 //     },
          //                 //     showDeleteButton: false);
          //               }),
          //         );
          //       },
          //       onTapSecondButton: () {
          //         /// used to going on review rating api
          //         Utility.closeDialog();
          //         if (!Get.isRegistered<RatingAndReviewController>()) {
          //           RatingAndReviewBinding().dependencies();
          //         }
          //         Get.find<RatingAndReviewController>().storeUserData(
          //             name: bookingDataById?.userDetails?.name ?? '',
          //             image: bookingDataById?.userDetails?.image ?? '',
          //             userReviews:
          //                 bookingDataById?.userDetails?.reviewCount ?? 0,
          //             toUserId: bookingDataById?.userDetails?.userId ?? 0,
          //             bookedId: bookingDataById?.bookingId ?? 0,
          //             userRating: bookingDataById?.userDetails?.rating ?? 0.0);
          //         RouteManagement.goToRatingReviewScreen();
          //       },
          //       secondButtonTitle: 'Rate Now',
          //       firstButtonBackgroundColor: AppColors.lightNavyBlue,
          //       firstButtonStyle: AppStyles.ubNavyBlue14W700,
          //       secondButtonBackgroundColor: AppColors.navyBlue,
          //       secondButtonStyle: AppStyles.ubWhite14700,
          //       imageName: Assets.imagesStar,
          //       showContentSvg: true,
          //       message:
          //           'Your job has been successfully completed.Please rate your experience with this sitter',
          //     );
          //   },
          //   firstButtonBackgroundColor: AppColors.lightNavyBlue,
          //   message:
          //       'Your nanny has marked this job as complete, please confirm that the job was completed successfully.',
          //   secondButtonSvg: Assets.iconsStar,
          //   showButtonSvg: true,
          //   firstButtonStyle: AppStyles.ubNavyBlue14W700,
          //   secondButtonBackgroundColor: AppColors.navyBlue,
          //   secondButtonStyle: AppStyles.ubWhite14700,
          // );
          if (response.data?.bookingStatus == 7) {
            Future.delayed(const Duration(seconds: 4));
            Utility.showAlertDialog(
              title: 'Congratulations',
              firstButtonTitle: 'Send Tip',
              onTapFirstButton: () {
                Get.to(
                  () => SendTipView(
                      userName:
                          '${bookingDataById?.userDetails?.name ?? ' '}${bookingDataById?.userDetails?.gender == 1 ? ', M' : bookingDataById?.userDetails?.gender == 2 ? ', F' : ''}',
                      image: bookingDataById?.userDetails?.image ?? '',
                      amountTextEditingController:
                          sendTipAmountTextEditingController,
                      onTapSubmitButton: () {
                        RouteManagement.goToCustomPaymentView(
                            isComeFromSendTip: true,
                            isComeFromConfirmBooking: false,
                            isCardAdded:
                                bookingDataById?.isCardAddedByCustomer ?? false,
                            onTapSubmit: () {
                              sendTip(
                                  amount:
                                      sendTipAmountTextEditingController.text,
                                  bookingId: bookingDataById?.bookingId ?? 0);
                            });

                        // RouteManagement.goToCustomPaymentView(
                        //     paymentDetails: cardList,
                        //     appBarTitle: ,
                        //     addNewCardButtonTitle: 'Add New Card',
                        //     addNewCardButtonBackgroundColor:
                        //         AppColors.lightNavyBlue,
                        //     onTapDeleteButton: () {},
                        //     submitButtonTitle: TranslationKeys.submit.tr,
                        //     submitButtonBackgroundColor: AppColors.navyBlue,
                        //     addNewCardButtonStyle: AppStyles.ubNavyBlue15W600,
                        //     onTapAddNewCardButton: () {
                        //       RouteManagement.goToAddPaymentMethodScreen(
                        //         isComeFromNannyProfile: false,
                        //         buttonText: TranslationKeys.submit.tr,
                        //         onTapButton: () {
                        //           Get.back();
                        //         },
                        //       );
                        //     },
                        //     onTapSubmitButton: () {
                        //       RouteManagement.goToSuccessView(
                        //         buttonText: TranslationKeys.backToHome.tr,
                        //         successSvg: '',
                        //         header: TranslationKeys.thankYou.tr,
                        //         subHeader:
                        //             TranslationKeys.yourNannyTipReceived.tr,
                        //         onTapButton: () {
                        //           RouteManagement.goToOffAllDashboard(
                        //               isFromSetting: false);
                        //         },
                        //         subTitleStyle: AppStyles.ubGrey16W500,
                        //         subHeaderMaxLines: 2,
                        //         headerMaxLines: 2,
                        //         successImage: Assets.imagesPinkHeart,
                        //         sendTipText: true,
                        //       );
                        //     },
                        //     showDeleteButton: false);
                      }),
                );
              },
              onTapSecondButton: () {
                /// used to going on review rating api
                Utility.closeDialog();
                if (!Get.isRegistered<RatingAndReviewController>()) {
                  RatingAndReviewBinding().dependencies();
                }
                Get.find<RatingAndReviewController>().storeUserData(
                  name: bookingDataById?.userDetails?.name ?? '',
                  image: bookingDataById?.userDetails?.image ?? '',
                  userReviews: bookingDataById?.userDetails?.reviewCount ?? 0,
                  toUserId: bookingDataById?.userDetails?.userId ?? 0,
                  bookedId: bookingDataById?.bookingId ?? 0,
                  userRating: bookingDataById?.userDetails?.rating ?? 0.0,
                  userGender: bookingDataById?.userDetails?.gender == 1
                      ? ', M'
                      : bookingDataById?.userDetails?.gender == 2
                          ? ', F'
                          : '',
                );
                RouteManagement.goToRatingReviewScreen();
              },
              secondButtonTitle: 'Rate Now',
              firstButtonBackgroundColor: AppColors.lightNavyBlue,
              firstButtonStyle: AppStyles.ubNavyBlue14W700,
              secondButtonBackgroundColor: AppColors.navyBlue,
              secondButtonStyle: AppStyles.ubWhite14700,
              imageName: Assets.imagesStar,
              showContentSvg: true,
              message:
                  'Your job has been successfully completed.Please rate your experience with this sitter',
            );
          }
          typeOfBooking(bookingStatus: response.data?.bookingStatus ?? 0);
          update();
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "update booking status  API ISSUE $s");
    }
  }

  /// used to get lat lon according to nanny position.
  TrackerLocationModel? trackerLocationModel;

  /// socket api used to get lat long and save to the nanny lat longs.
  updateNannyLatLong() async {
    socket.hubConnection.on('TranckNannyResponse', (arguments) {
      var value = arguments?[0] as Map<String, dynamic>;
      var response = TrackerLocationModel.fromJson(value);
      log('tracking lat long Response:$response');
      if (response.response == AppConstants.apiResponseSuccess) {
        trackerLocationModel = response;
      } else {
        toast(msg: response.message.toString(), isError: true);
      }
      update(['customer_tracking']);
      addPolyLine(
          bookingDataById: bookingDataById,
          trackerLocationModel: trackerLocationModel);
    });
  }

  /// used to initialize google Map
  GoogleMapController? googleMapController;

  /// used  for create poly Line with the road by route.
  addPolyLine(
      {BookingDataById? bookingDataById,
      TrackerLocationModel? trackerLocationModel}) async {
    var fistCoordinate = LatLng(
      double.parse(bookingDataById?.latitude ?? '0.0'),
      double.parse(bookingDataById?.longitude ?? '0.0'),
    );
    var secondCoordinate = LatLng(
      trackerLocationModel != null
          ? double.parse(
              trackerLocationModel.data?.latitude.toString() ?? '0.0')
          : double.parse(bookingDataById?.userDetails?.latitude ?? '0.0'),
      trackerLocationModel != null
          ? double.parse(trackerLocationModel.data?.longitude ?? '0.0')
          : double.parse(bookingDataById?.userDetails?.longitude ?? '0.0'),
    );

    customerPolyLine =
        await Utility.setPolylineDirection(fistCoordinate, secondCoordinate);
    update(['customer_tracking']);
  }

  @override
  void onInit() {
    super.onInit();
    updateNannyLatLong();
  }

  /// used to send tip
  Future<void> sendTip({required String amount, required int bookingId}) async {
    try {
      if (!(await Utils.hasNetwork())) {
        return;
      }
      var body = {
        "bookingId": bookingId,
        "amount": amount,
        "dateTime": DateTime.now().toUtc().toIso8601String(),
      };
      log('body of Send tip :$body');
      _apiHelper.postApi(ApiUrls.sendTip, jsonEncode(body)).futureValue(
          (value) {
        printInfo(info: "Send Tip response  $value");
        var response = BookingDataByIdResponseModel.fromJson(value);
        if (response.response == AppConstants.apiResponseSuccess) {
          /// used to show tip received by nanny.
          RouteManagement.goToSuccessView(
            buttonText: TranslationKeys.backToHome.tr,
            successSvg: '',
            header: TranslationKeys.thankYou.tr,
            subHeader: TranslationKeys.yourNannyTipReceived.tr,
            onTapButton: () {
              RouteManagement.goToOffAllDashboard(isFromSetting: false);
            },
            subTitleStyle: AppStyles.ubGrey16W500,
            subHeaderMaxLines: 2,
            headerMaxLines: 2,
            successImage: Assets.imagesPinkHeart,
            sendTipText: true,
          );
        } else {
          toast(msg: response.message.toString(), isError: true);
        }
      }, retryFunction: () {});
    } catch (e, s) {
      toast(msg: e.toString(), isError: true);
      printError(info: "Send tip API ISSUE $s");
    }
  }
}
