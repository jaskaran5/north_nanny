import 'dart:developer';

import 'package:flutter/material.dart';
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

class CurrentLocationGoogleMap extends StatelessWidget {
  const CurrentLocationGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    // var googleMapViewController = Get.put(GoogleMapViewController());
    return GetBuilder<GoogleMapViewController>(
      builder: (googleMapViewController) {
        return Scaffold(
            appBar: CustomAppbarWidget(
              backgroundColor: Colors.transparent,
              titleWidget: GooglePlaceAutoCompleteTextField(
                textEditingController:
                    googleMapViewController.searchLocationTextEditingController,
                googleAPIKey: StringConstants.googleApiKey,
                boxDecoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                inputDecoration: InputDecoration(
                  hintText: "Search your location",
                  border: InputBorder.none,
                  hintStyle: AppStyles.ubBlack14W700,
                  enabledBorder: InputBorder.none,
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
                containerHorizontalPadding: Dimens.ten,
                // OPTIONAL// If you want to customize list view item builder
                itemBuilder: (context, index, Prediction prediction) {
                  return prediction.id?.isEmpty == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
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
                      target: googleMapViewController.currentLatLng.value!,
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      googleMapViewController.initializeGoogleMapController(
                          controller: controller);
                    },
                    markers: <Marker>{
                      Marker(
                        markerId: const MarkerId('current_location'),
                        position: googleMapViewController.currentLatLng.value ??
                            const LatLng(0, 0),
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
