import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:northshore_nanny_flutter/app/modules/common/booking_details/booking_detail_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';

import '../../../res/theme/colors.dart';
import '../../../res/theme/dimens.dart';

class CustomerTrackingView extends StatelessWidget {
  const CustomerTrackingView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<BookingDetailController>(
        id: 'customer_tracking',
        builder: (trackingController) => Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          double.parse(
                              trackingController.bookingDataById?.latitude ??
                                  '0.0'),
                          double.parse(
                              trackingController.bookingDataById?.longitude ??
                                  '0.0')),
                      zoom: Dimens.fifteen),
                  myLocationEnabled: true,
                  indoorViewEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: true,
                  scrollGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (googleController) {
                    trackingController.googleMapController = googleController;

                    debugPrint(
                        '---------------- >>>>>>>>>> map created <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  ');

                    trackingController.update(['customer_tracking']);
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId(
                          trackingController.bookingDataById?.latitude ?? ''),
                      position: LatLng(
                        trackingController.trackerLocationModel != null
                            ? double.parse(trackingController
                                    .trackerLocationModel?.data?.latitude
                                    .toString() ??
                                '0.0')
                            : double.parse(trackingController
                                    .bookingDataById?.userDetails?.latitude ??
                                '0.0'),
                        trackingController.trackerLocationModel != null
                            ? double.parse(trackingController
                                    .trackerLocationModel?.data?.longitude ??
                                '0.0')
                            : double.parse(trackingController
                                    .bookingDataById?.userDetails?.longitude ??
                                '0.0'),
                      ),
                      flat: true,
                    ),
                  },
                  polylines: {
                    trackingController.customerPolyLine ??
                        Polyline(
                          polylineId: const PolylineId('nannyLine1'),
                          color: AppColors.navyBlue3288DE,
                          points: [
                            LatLng(
                              double.parse(trackingController
                                      .bookingDataById?.latitude ??
                                  '0.0'),
                              double.parse(trackingController
                                      .bookingDataById?.longitude ??
                                  '0.0'),
                            ),
                            LatLng(
                              trackingController.trackerLocationModel != null
                                  ? double.parse(trackingController
                                          .trackerLocationModel?.data?.latitude
                                          .toString() ??
                                      '0.0')
                                  : double.parse(trackingController
                                          .bookingDataById
                                          ?.userDetails
                                          ?.latitude ??
                                      '0.0'),
                              trackingController.trackerLocationModel != null
                                  ? double.parse(trackingController
                                          .trackerLocationModel
                                          ?.data
                                          ?.longitude ??
                                      '0.0')
                                  : double.parse(trackingController
                                          .bookingDataById
                                          ?.userDetails
                                          ?.longitude ??
                                      '0.0'),
                            ),
                          ],
                        ),
                  },
                  mapType: MapType.normal,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.back();
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: Dimens.edgeInsets10,
                      child: SvgPicture.asset(Assets.iconsBack),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
