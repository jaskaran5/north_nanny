// import 'package:hot_spot/common/utils/utilities.dart';
// import 'package:hot_spot/data/network/api_constant.dart';
// import 'package:hot_spot/dataStorage/app_data_base.dart';
// import 'package:signalr_netcore/signalr_client.dart';
//
// class SignalRHelper {
//   String tag = "socket";
//
//   static final SignalRHelper _singleton = SignalRHelper._internal();
//
//   factory SignalRHelper() => _singleton;
//
//   SignalRHelper._internal();
//
//   late HubConnection _hubConnection;
//
//   bool isConnected = false;
//   bool isUserConnected = false;
//
//   Future<void> init() async {
//     try {
//       if (AppLocalStorage().token != null &&
//           AppLocalStorage().token.isNotEmpty) {
//         final String accessToken =
//         AppLocalStorage().token.split('Bearer').last.replaceAll(" ", "");
//         _hubConnection = HubConnectionBuilder()
//             .withUrl(
//           hubConnectionUrl,
//           options: HttpConnectionOptions(
//             transport: HttpTransportType.WebSockets,
//             skipNegotiation: true,
//             logMessageContent: true,
//             accessTokenFactory: () => Future.value(accessToken),
//           ),
//         )
//             .withAutomaticReconnect()
//             .build();
//
//         _initListeners();
//
//         await startConnection();
//       }
//     } catch (e) {
//       Utils.printLog(e);
//     }
//   }
//
//   Future<void> startConnection() async {
//     try {
//       await _hubConnection.start();
//       isConnected = true;
//       isUserConnected = true;
//       Utils.printLog("Connected: ${_hubConnection.connectionId}");
//     } catch (e) {
//       Utils.printLog("Connection error: $e");
//       isConnected = false;
//       isUserConnected = false;
//     }
//   }
//
//   void _initListeners() {
//     _hubConnection.onreconnecting(({error}) {
//       Utils.printLog("onConnectError $error");
//       isConnected = false;
//       isUserConnected = false;
//     });
//
//     _hubConnection.onreconnected(({connectionId}) {
//       Utils.printLog("onReconnected $connectionId");
//       isConnected = true;
//       isUserConnected = true;
//     });
//     _hubConnection.onclose(({error}) {
//       Utils.printLog('$tag onClose: $error');
//       isUserConnected = false;
//       isConnimport 'package:hot_spot/common/utils/utilities.dart';
//       import 'package:hot_spot/data/network/api_constant.dart';
//       import 'package:hot_spot/dataStorage/app_data_base.dart';
//       import 'package:signalr_netcore/signalr_client.dart';
//
//       class SignalRHelper {
//       String tag = "socket";
//
//       static final SignalRHelper _singleton = SignalRHelper._internal();
//
//       factory SignalRHelper() => _singleton;
//
//       SignalRHelper._internal();
//
//       late HubConnection _hubConnection;
//
//       bool isConnected = false;
//       bool isUserConnected = false;
//
//       Future<void> init() async {
//       try {
//       if (AppLocalStorage().token != null &&
//       AppLocalStorage().token.isNotEmpty) {
//       final String accessToken =
//       AppLocalStorage().token.split('Bearer').last.replaceAll(" ", "");
//       _hubConnection = HubConnectionBuilder()
//           .withUrl(
//       hubConnectionUrl,
//       options: HttpConnectionOptions(
//       transport: HttpTransportType.WebSockets,
//       skipNegotiation: true,
//       logMessageContent: true,
//       accessTokenFactory: () => Future.value(accessToken),
//       ),
//       )
//           .withAutomaticReconnect()
//           .build();
//
//       _initListeners();
//
//       await startConnection();
//       }
//       } catch (e) {
//       Utils.printLog(e);
//       }
//       }
//
//       Future<void> startConnection() async {
//       try {
//       await _hubConnection.start();
//       isConnected = true;
//       isUserConnected = true;
//       Utils.printLog("Connected: ${_hubConnection.connectionId}");
//       } catch (e) {
//       Utils.printLog("Connection error: $e");
//       isConnected = false;
//       isUserConnected = false;
//       }
//       }
//
//       void _initListeners() {
//       _hubConnection.onreconnecting(({error}) {
//       Utils.printLog("onConnectError $error");
//       isConnected = false;
//       isUserConnected = false;
//       });
//
//       _hubConnection.onreconnected(({connectionId}) {
//       Utils.printLog("onReconnected $connectionId");
//       isConnected = true;
//       isUserConnected = true;
//       });
//       _hubConnection.onclose(({error}) {
//       Utils.printLog('$tag onClose: $error');
//       isUserConnected = false;
//       isConnected = false;
//       reconnect();
//       });
//       }
//
//       void reconnect() async {
//       if (!isConnected) {
//       await startConnection();
//       }
//       }
//
//       HubConnection getHubConnection() => _hubConnection;
//
//       void disconnectUser() {
//       _hubConnection.stop();
//       isConnected = false;
//       isUserConnected = false;
//       }
//       }ected = false;
//       reconnect();
//     });
//   }
//
//   void reconnect() async {
//     if (!isConnected) {
//       await startConnection();
//     }
//   }
//
//   HubConnection getHubConnection() => _hubConnection;
//
//   void disconnectUser() {
//     _hubConnection.stop();
//     isConnected = false;
//     isUserConnected = false;
//   }
// }