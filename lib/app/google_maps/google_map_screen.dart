import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:northshore_nanny_flutter/app/google_maps/google_map_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

import '../data/storage/storage.dart';
import '../res/constants/assets.dart';

class CurrentLocationGoogleMap extends StatelessWidget {
  CurrentLocationGoogleMap({super.key});

  final isFromEdit = Get.arguments ?? false;

  @override
  Widget build(BuildContext context) {
    // var googleMapViewController = Get.put(GoogleMapViewController());
    return GetBuilder<GoogleMapViewController>(
      initState: (state) {
        Get.find<GoogleMapViewController>()
            .updateIsFromEdit(isFrom: isFromEdit);
      },
      builder: (googleMapViewController) {
        return Scaffold(
            appBar: CustomAppbarWidget(
              backgroundColor: Colors.transparent,
              addBackButton: false,
              leadingWidth: Dimens.zero,
              titleWidget: GooglePlaceAutoCompleteTextField(
                textEditingController:
                    googleMapViewController.searchLocationTextEditingController,
                googleAPIKey: StringConstants.googleApiKey,

                boxDecoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                focusNode: googleMapViewController.focusNode,
                inputDecoration: InputDecoration(
                  hintText: "Search your location",
                  border: InputBorder.none,
                  hintStyle: AppStyles.ubBlack14W700,
                  enabledBorder: InputBorder.none,
                  prefixIcon:  GestureDetector(
                    onTap: () {
                          Get.focusScope?.unfocus();
                          Get.back();
                        },
                    child: Padding(
                      padding: Dimens.edgeInsetsL2R4,
                      child: SvgPicture.asset(
                        Assets.iconsBack,
                        height: Dimens.fortyOne,
                        width: Dimens.fortyOne,
                        alignment: Alignment.center,
                      ),
                    ),
                  )
                ),
                textStyle: AppStyles.ubBlack14W700,
                debounceTime: 400,
                countries: const ["in", "us"],
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (Prediction prediction) {
                  log('updated data:$prediction');
                  googleMapViewController.updateCameraPositionOfMapBySearch(
                      lat: prediction.lat.toString(),
                      lon: prediction.lng.toString());
                },

                itemClick: (Prediction prediction) {
                  googleMapViewController.searchLocationTextEditingController
                      .text = prediction.description ?? "";
                  googleMapViewController
                          .searchLocationTextEditingController.selection =
                      TextSelection.fromPosition(TextPosition(
                          offset: prediction.description?.length ?? 0));
                  log('item click ${googleMapViewController.searchLocationTextEditingController}   ${prediction.lat} ${prediction.lng}');
                },
                seperatedBuilder: Divider(
                  color: AppColors.lightNavyBlue,
                  height: Dimens.one,
                ),
                containerHorizontalPadding: Dimens.zero,
                // OPTIONAL// If you want to customize list view item builder
                itemBuilder: (context, index, Prediction prediction) {
                  return prediction.id?.isEmpty == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                        padding: Dimens.edgeInsets10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on),
                            Dimens.boxWidth8,
                            Expanded(
                                child: Text(prediction.description ?? ""))
                          ],
                        ),
                      );
                },

                isCrossBtnShown: true,

                // default 600 ms ,
              ),
            ),
            body: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Obx(
                () => GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          googleMapViewController
                                      .currentLatLng.value.latitude !=
                                  0.0
                              ? googleMapViewController
                                  .currentLatLng.value.latitude
                              : Storage.getValue(StringConstants.latitude),
                          googleMapViewController
                                      .currentLatLng.value.longitude !=
                                  0.0
                              ? googleMapViewController
                                  .currentLatLng.value.longitude
                              : Storage.getValue(StringConstants.longitude)),
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      googleMapViewController.initializeGoogleMapController(
                          controller: controller);
                    },
                    markers: <Marker>{
                      Marker(
                        markerId: const MarkerId('current_location'),
                        position: googleMapViewController
                                    .currentLatLng.value.longitude ==
                                0.0
                            ? LatLng(Storage.getValue(StringConstants.latitude),
                                Storage.getValue(StringConstants.longitude))
                            : googleMapViewController.currentLatLng.value,
                        infoWindow: const InfoWindow(
                          title: 'Current Location',
                          snippet: 'Your current location',
                        ),
                      ),
                    }),
              ),
            ),
            floatingActionButton: CustomButton(
              titleStyle: AppStyles.fffUrban15w600,
              title: "Done",
              backGroundColor: AppColors.navyBlue,
              onTap: () {
                if (googleMapViewController.isFromEdit.value) {
                  googleMapViewController.getEditLocation().then((value) {
                    log('value>>>> ${value.location}');
                    Get.back(result: value);
                  });
                } else {
                  googleMapViewController.saveLocationCoordinates();
                }
              },
            ));
      },
    );
  }
}
