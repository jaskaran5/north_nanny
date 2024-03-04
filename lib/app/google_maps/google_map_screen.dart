import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/google_maps/google_map_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_button.dart';

class CurrentLocationGoogleMap extends StatelessWidget {
  const CurrentLocationGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleMapViewController>(
      builder: (googleMapViewController) {
        return Scaffold(
            body: SizedBox(
              height: Get.height,
              width: Get.width,
              child: GoogleMap(
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(googleMapViewController.currentLat.value,
                      googleMapViewController.currentLong.value),
                  zoom: 12.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  googleMapViewController.initilizedGoogleMapController(
                      contro: controller);
                },
              ),
            ),
            floatingActionButton: CustomButton(
              titleStyle: AppStyles.navyBlue15UbW600,
              title: "Done",
              onTap: () {
                Get.back();
              },
            )

            //  FloatingActionButton(
            //   child:

            //   const Icon(
            //     Icons.location_searching,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     googleMapViewController.getUserLocation();
            //   },
            // ),
            );
      },
    );
  }
}
