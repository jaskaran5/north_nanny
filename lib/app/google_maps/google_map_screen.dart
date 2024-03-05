import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/google_maps/google_map_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

class CurrentLocationGoogleMap extends StatelessWidget {
  const CurrentLocationGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    var googleMapViewController = Get.put(GoogleMapViewController());
    return Scaffold(
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Obx(
            () => GoogleMap(
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: googleMapViewController.currentLatLng.value!,
                  zoom: 12.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  googleMapViewController.googleMapController
                      .complete(controller);
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
          titleStyle: AppStyles.navyBlue15UbW600,
          title: "Done",
          backGroundColor: AppColors.navyBlue3288DE,
          onTap: () {
            googleMapViewController.saveLocationCoordinates();
          },
        ));
  }
}
