// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:new_project/core/calender/helper/cal_topbar.dart';
// import 'package:new_project/core/calender/screen/calendar_event_scree.dart';
// import 'package:new_project/core/calender/screen/calendar_service_screen.dart';
// import 'package:new_project/core/calender/screen/calendar_taining_screen.dart';
// import 'package:new_project/src/common_widget/common_text.dart';
// import 'package:new_project/src/extension/extension.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import '../../../../src/extension/app_string_constant.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';
//
// import '../controller/calendar_controller.dart';
//
// CalenderController calenderController = Get.put(CalenderController());
//
// class CalenderHomeScreen extends StatefulWidget {
//   final String? checking;
//   const CalenderHomeScreen({Key? key, this.checking}) : super(key: key);
//
//   @override
//   State<CalenderHomeScreen> createState() => _CalenderHomeScreenState();
// }
//
// class _CalenderHomeScreenState extends State<CalenderHomeScreen>
//     with TickerProviderStateMixin {
//   CalenderController calenderController = Get.put(CalenderController());
//   GlobalKey<FormState> abcKey = GlobalKey<FormState>();
//
//   TabController? _tabController;
//   @override
//   void initState() {
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController!.addListener(() {
//       if (!_tabController!.indexIsChanging) {
//         if (_tabController!.index == 0) {
//           calenderController.calendarApiCall('1', 'tra');
//         } else if (_tabController!.index == 1) {
//           calenderController.serviceCall('2', 'ser');
//         } else if (_tabController!.index == 2) {
//           calenderController.eventCall('3', 'eve');
//         }
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: abcKey,
//         backgroundColor: AppString().grey,
//         body: GetBuilder<CalenderController>(
//           builder: (controller) => controller.notifyLoading.value
//               ? Shimmer.fromColors(
//             baseColor: Colors.grey,
//             highlightColor: Colors.grey.shade200,
//             direction: ShimmerDirection.ltr,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   35.pixelH,
//                   Container(
//                     height: 30,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.black),
//                   ),
//                   20.pixelH,
//                   for (var i = 0; i < 2; i++)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20, bottom: 50),
//                       child: Container(
//                         height: i == 0 ? 270 : 230,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.black),
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           )
//               : Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                   color: AppString().white,
//                   height: 110,
//                   width: MediaQuery.of(context).size.width,
//                   child: const Padding(
//                     padding: EdgeInsets.only(
//                         left: 23, right: 5, top: 40, bottom: 15),
//                     child: AddCalenderTopBar(
//                       title: "Calendar",
//                     ),
//                   )),
//               Divider(
//                 color: AppString().light_grey,
//                 height: 1,
//                 thickness: 1.5,
//               ),
//               Expanded(
//                   flex: 1,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width,
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 10, right: 10, top: 7, bottom: 0),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       controller.datePickerController
//                                           .backward!();
//                                       controller.calendarNotifyApiCall(
//                                         DateFormat('yyy').format(
//                                             DateTime.parse(controller
//                                                 .sdate
//                                                 .toString())),
//                                         DateFormat('MM').format(
//                                             DateTime.parse(controller
//                                                 .sdate
//                                                 .toString())),
//                                       );
//                                     });
//                                     controller.trainingCalanderModel.data!
//                                         .clear();
//
//                                     controller.serviceCalanderModel.data!
//                                         .clear();
//                                     controller.eventCalanderModel.data!
//                                         .clear();
//                                   },
//                                   child: Icon(
//                                     Icons.chevron_left,
//                                     color: AppString().wine_dart,
//                                     size: 27,
//                                   ),
//                                 ),
//                                 Text(
//                                     DateFormat('MMMM yyy')
//                                         .format(DateTime.parse(
//                                       controller.sdate
//                                           .toIso8601String()
//                                           .substring(0, 10),
//                                     ))
//                                         .toString()
//                                         .capitalize!,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     )),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       controller.datePickerController
//                                           .forward!();
//                                       controller.calendarNotifyApiCall(
//                                         DateFormat('yyy').format(
//                                             DateTime.parse(controller
//                                                 .sdate
//                                                 .toString())),
//                                         DateFormat('MM').format(
//                                             DateTime.parse(controller
//                                                 .sdate
//                                                 .toString())),
//                                       );
//                                     });
//                                     controller.trainingCalanderModel.data!
//                                         .clear();
//                                     controller.serviceCalanderModel.data!
//                                         .clear();
//                                     controller.eventCalanderModel.data!
//                                         .clear();
//                                   },
//                                   child: Icon(
//                                     Icons.chevron_right,
//                                     color: AppString().wine_dart,
//                                     size: 27,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         GetBuilder<CalenderController>(
//                             builder: (controller) {
//                               return Container(
//                                 height: 340,
//                                 color: AppString().white,
//                                 child: SfDateRangePicker(
//                                     headerHeight: 0,
//                                     navigationMode:
//                                     DateRangePickerNavigationMode.none,
//                                     onSelectionChanged: (dateTimeData) {
//                                       if (_tabController!.index == 0) {
//                                         controller.currentData =
//                                             DateFormat('yyy-MM-dd')
//                                                 .format(dateTimeData.value);
//                                         controller.calendarApiCall(
//                                             '1', 'tra');
//                                         setState(() {
//                                           controller.selectedDate =
//                                               dateTimeData.value;
//                                         });
//                                       } else if (_tabController!.index == 1) {
//                                         controller.currentData =
//                                             DateFormat('yyy-MM-dd')
//                                                 .format(dateTimeData.value);
//                                         controller.serviceCall('2', 'ser');
//                                         setState(() {
//                                           controller.selectedDate =
//                                               dateTimeData.value;
//                                         });
//                                       } else if (_tabController!.index == 2) {
//                                         controller.currentData =
//                                             DateFormat('yyy-MM-dd')
//                                                 .format(dateTimeData.value);
//                                         controller.eventCall('3', 'eve');
//                                         setState(() {
//                                           controller.selectedDate =
//                                               dateTimeData.value;
//                                         });
//                                       }
//                                     },
//                                     cellBuilder: (BuildContext context,
//                                         DateRangePickerCellDetails details) {
//                                       final bool checkTrainging =
//                                       trainingSchedulesDate(details.date);
//                                       final checkService =
//                                       serviceSchedulesDate(details.date);
//                                       final checkEvent =
//                                       eventSchedulesDate(details.date);
//                                       return GetBuilder<CalenderController>(
//                                         builder: (controller) => Container(
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: Colors.white)),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                             children: <Widget>[
//                                               Container(
//                                                 height: 30,
//                                                 width: 30,
//                                                 decoration: BoxDecoration(
//                                                     color: controller
//                                                         .selectedDate
//                                                         .day ==
//                                                         details.date.day
//                                                         ? DateFormat('yyy-MM')
//                                                         .format(
//                                                         controller
//                                                             .sdate) ==
//                                                         DateFormat(
//                                                             'yyy-MM')
//                                                             .format(
//                                                             controller
//                                                                 .selectedDate)
//                                                         ? AppString()
//                                                         .light_wine_dart
//                                                         : Colors.white
//                                                         : Colors.white,
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                         20)),
//                                                 child: Center(
//                                                   child: Text(
//                                                     details.date.day
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                       FontWeight.bold,
//                                                       color: controller
//                                                           .selectedDate
//                                                           .day ==
//                                                           details.date.day
//                                                           ? DateFormat('yyy-MM').format(
//                                                           controller
//                                                               .sdate) ==
//                                                           DateFormat(
//                                                               'yyy-MM')
//                                                               .format(controller
//                                                               .selectedDate)
//                                                           ? Colors.white
//                                                           : Colors.grey
//                                                           .shade600
//                                                           : Colors
//                                                           .grey.shade600,
//                                                       fontSize: 13,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                                 children: [
//                                                   checkTrainging
//                                                       ? const Icon(
//                                                     Icons.circle,
//                                                     size: 7.5,
//                                                     color:
//                                                     Color.fromARGB(
//                                                         255,
//                                                         32,
//                                                         227,
//                                                         38),
//                                                   )
//                                                       : const SizedBox(),
//                                                   checkService
//                                                       ? const Icon(
//                                                     Icons.circle,
//                                                     color: Colors.pink,
//                                                     size: 7.5,
//                                                   )
//                                                       : const SizedBox(),
//                                                   checkEvent
//                                                       ? const Icon(
//                                                     Icons.circle,
//                                                     color: Colors.blue,
//                                                     size: 7.5,
//                                                   )
//                                                       : const SizedBox(),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     view: DateRangePickerView.month,
//                                     headerStyle:
//                                     const DateRangePickerHeaderStyle(
//                                         textAlign: TextAlign.center,
//                                         textStyle: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                     monthCellStyle:
//                                     DateRangePickerMonthCellStyle(
//                                         textStyle: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.grey.shade700,
//                                           fontSize: 12,
//                                         )),
//                                     monthViewSettings:
//                                     const DateRangePickerMonthViewSettings(
//                                         viewHeaderHeight: 50,
//                                         dayFormat: 'EEE',
//                                         viewHeaderStyle:
//                                         DateRangePickerViewHeaderStyle(
//                                           textStyle: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 13,
//                                               color: Colors.black),
//                                         )),
//                                     selectionMode:
//                                     DateRangePickerSelectionMode.single,
//                                     selectionColor: Colors.white,
//                                     initialSelectedDate:
//                                     controller.selectedDate,
//                                     controller:
//                                     controller.datePickerController,
//                                     showNavigationArrow: true,
//                                     allowViewNavigation: false,
//                                     onViewChanged:
//                                         (dateRangePickerViewChangedArgs) {
//                                       controller.sdate = DateTime.parse(
//                                           dateRangePickerViewChangedArgs
//                                               .visibleDateRange.startDate
//                                               .toString());
//                                     }),
//                               );
//                             }),
//                         15.pixelH,
//                         Container(
//                           color: Colors.white,
//                           height: 60,
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Column(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: TabBar(
//                                       controller: _tabController,
//                                       isScrollable: false,
//                                       indicatorColor:
//                                       AppString().wine_dart,
//                                       labelStyle: const TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w700),
//                                       indicatorSize:
//                                       TabBarIndicatorSize.tab,
//                                       labelColor: AppString().wine_dart,
//                                       unselectedLabelColor: Colors.grey,
//                                       dividerColor: Colors.transparent,
//                                       unselectedLabelStyle:
//                                       const TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 17),
//                                       onTap: (value) {},
//                                       tabs: [
//                                         Tab(
//                                           child: Row(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                             children: [
//                                               TextCommon(msg: 'Training'),
//                                               5.pixelW,
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 3),
//                                                 child: Container(
//                                                   height: 8,
//                                                   width: 8,
//                                                   decoration: BoxDecoration(
//                                                       color: const Color
//                                                           .fromARGB(255,
//                                                           32, 227, 38),
//                                                       borderRadius:
//                                                       BorderRadius
//                                                           .circular(
//                                                           5)),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Tab(
//                                           child: Row(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                             children: [
//                                               const Text("Services"),
//                                               5.pixelW,
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 3),
//                                                 child: Container(
//                                                   height: 8,
//                                                   width: 8,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.pink,
//                                                       borderRadius:
//                                                       BorderRadius
//                                                           .circular(
//                                                           5)),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Tab(
//                                           child: Row(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                             children: [
//                                               const Text("Events"),
//                                               5.pixelW,
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 3),
//                                                 child: Container(
//                                                   height: 8,
//                                                   width: 8,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.blue,
//                                                       borderRadius:
//                                                       BorderRadius
//                                                           .circular(
//                                                           5)),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       ]),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 350,
//                           child: TabBarView(
//                               controller: _tabController,
//                               children: const [
//                                 // Training section
//                                 TrainingScreen(),
//                                 //  Services Screen ------>
//                                 ServiceSreen(),
//                                 // Event section---->
//                                 EventScreen()
//                               ]),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ))
//             ],
//           ),
//         ));
//   }
//
//   bool trainingSchedulesDate(DateTime date) {
//     for (var i = 0;
//     i < calenderController.calendarNofityModel.data!.length;
//     i++) {
//       if (calenderController.calendarNofityModel.data![i].isTraining == 1) {
//         if ('${date.month}-${date.day}' ==
//             '${DateFormat('M').format(DateTime.parse(calenderController.calendarNofityModel.data![1].selectedDate.toString()))}-${int.parse(DateFormat('d').format(DateTime.parse(calenderController.calendarNofityModel.data![i].selectedDate.toString())))}') {
//           return true;
//         }
//       }
//     }
//
//     return false;
//   }
//
//   bool serviceSchedulesDate(DateTime date) {
//     for (var i = 0;
//     i < calenderController.calendarNofityModel.data!.length;
//     i++) {
//       if (calenderController.calendarNofityModel.data![i].isService == 1) {
//         if ('${date.month}-${date.day}' ==
//             '${DateFormat('M').format(DateTime.parse(calenderController.calendarNofityModel.data![1].selectedDate.toString()))}-${int.parse(DateFormat('d').format(DateTime.parse(calenderController.calendarNofityModel.data![i].selectedDate.toString())))}') {
//           return true;
//         }
//       }
//     }
//
//     return false;
//   }
//
//   bool eventSchedulesDate(DateTime date) {
//     for (var i = 0;
//     i < calenderController.calendarNofityModel.data!.length;
//     i++) {
//       if (calenderController.calendarNofityModel.data![i].isEvent == 1) {
//         if ('${date.month}-${date.day}' ==
//             '${DateFormat('M').format(DateTime.parse(calenderController.calendarNofityModel.data![1].selectedDate.toString()))}-${int.parse(DateFormat('d').format(DateTime.parse(calenderController.calendarNofityModel.data![i].selectedDate.toString())))}') {
//           return true;
//         }
//       }
//     }
//
//     return false;
//   }
// }
