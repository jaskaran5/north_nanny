import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../navigators/routes_management.dart';
import '../res/theme/colors.dart';
import '../res/theme/dimens.dart';
import '../res/theme/styles.dart';
import '../utils/translations/translation_keys.dart';
import 'app_text.dart';

class CustomBookingTrackLocation extends StatelessWidget {
  const CustomBookingTrackLocation(
      {super.key,
      required this.firstWidget,
      required this.showTrackLocation,
      required this.latitude,
      required this.longitude,
      required this.polyline,
      required this.markers,
      this.onMapCreated});
  final Widget firstWidget;
  final bool showTrackLocation;
  final double latitude;
  final double longitude;
  final Set<Polyline> polyline;
  final Set<Marker> markers;
  final Function(GoogleMapController)? onMapCreated;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        decoration: BoxDecoration(
          color: AppColors.navyBlue,
          borderRadius: BorderRadius.circular(Dimens.twenty),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            firstWidget,
            Dimens.boxHeight14,
            if (showTrackLocation) ...[
              AppText(
                text: TranslationKeys.trackLocation.tr,
                style: AppStyles.ubWhite14700,
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
              Dimens.boxHeight14,
              GestureDetector(
                onTap: () {
                  debugPrint('Going to Nanny Tracking view');

                  /// used to going tracking view.
                  RouteManagement.goToNannyTrackingView();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.ten),
                  child: Container(
                    height: Dimens.hundredFourteen,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.ten),
                    ),
                    child: IgnorePointer(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: Dimens.fourteen,
                        ),
                        myLocationEnabled: false,
                        indoorViewEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        myLocationButtonEnabled: false,
                        onMapCreated: onMapCreated,
                        markers: markers,
                        polylines: polyline,
                        mapType: MapType.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
}
