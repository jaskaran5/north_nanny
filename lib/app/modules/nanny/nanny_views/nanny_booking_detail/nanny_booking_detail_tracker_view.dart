
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/modules/nanny/nanny_views/nanny_booking_detail/nanny_booking_detail_controller.dart';

import '../../../../res/theme/colors.dart';
import '../../../../res/theme/dimens.dart';

class NannyBookingDetailTrackerView extends StatelessWidget {
  const NannyBookingDetailTrackerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      GetBuilder<NannyBookingDetailController>(
        id: 'tracking-view',
        builder: (trackingController) {
          log("trackingController.nannyPoliyLine>>>>>>>>${trackingController.nannyPolyLine}");
          return Scaffold(
          body: SafeArea(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                    trackingController.currentPosition?.latitude ??
                        double.parse(trackingController
                                .bookingDetailsModel?.data?.latitude ??
                            '0.0'),
                    trackingController.currentPosition?.longitude ??
                        double.parse(trackingController
                                .bookingDetailsModel?.data?.longitude ??
                            '0.0'),
                  ),
                  zoom: Dimens.twelve),
              myLocationEnabled: true,
              indoorViewEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              mapToolbarEnabled: true,
              scrollGesturesEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: trackingController.onMapCreated,
              markers: {
                Marker(
                  markerId: MarkerId(trackingController
                          .bookingDetailsModel?.data?.userDetails?.latitude
                          .toString() ??
                      ''),
                  flat: true,
                  position: LatLng(
                    double.parse(trackingController
                            .bookingDetailsModel?.data?.userDetails?.latitude ??
                        '0.0'),
                    double.parse(trackingController.bookingDetailsModel?.data
                            ?.userDetails?.longitude ??
                        '0.0'),
                  ),
                )
              },
              polylines: {
                trackingController.nannyPolyLine ??
                Polyline(
                  polylineId: const PolylineId('line'),
                  color: AppColors.navyBlue3288DE,
                  points: [
                    LatLng(
                        trackingController.currentPosition?.latitude ??
                            double.parse(trackingController
                                    .bookingDetailsModel?.data?.latitude ??
                                '0.0'),
                        trackingController.currentPosition?.longitude ??
                            double.parse(trackingController
                                    .bookingDetailsModel?.data?.longitude ??
                                '0.0')),
                    LatLng(
                        double.parse(trackingController.bookingDetailsModel
                                ?.data?.userDetails?.latitude ??
                            '0.0'),
                        double.parse(trackingController.bookingDetailsModel
                                ?.data?.userDetails?.longitude ??
                            '0.0')),
                  ],
                ),
              },
              mapType: MapType.normal,
            ),
          ),
        );
        },
      );
}
