import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  RxBool showListView = false.obs;
  RxBool isGoogleMap = true.obs;
  final Set<Marker> markers = {};

  List<String> homeCustomList = [
    'Distance: 3 miles',
    'Age: 40',
    'Experience: 7+ yrs'
  ];

  late GoogleMapController googleMapController;

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(
        37.42796133580664,
        -122.085749655962,
      ),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  /// UPDATE SCREEN WITH TAP -- GOOGLE MAP/ LIST VIEW

  updateScreen() {
    isGoogleMap.value = !isGoogleMap.value;
    showListView.value = !showListView.value;
    update();
  }

  /// *******---------------------------->>>>>>>>>>> ON MAP CREATED

  void onMapCreated({required GoogleMapController controller}) async {
    googleMapController = controller;

    markers.add(
      const Marker(
        markerId: MarkerId("nanny"),
        position: LatLng(37.42796133580664, -122.085749655962),
        // icon: await BitmapDescriptor.fromAssetImage(
        //     const ImageConfiguration(devicePixelRatio: 2.0), Assets.iconsMap),
      ),
    );
  }
}
