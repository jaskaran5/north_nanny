import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:northshore_nanny_flutter/app/data/storage/storage.dart';
import 'package:northshore_nanny_flutter/app/res/constants/api_urls.dart';
import 'package:northshore_nanny_flutter/app/res/constants/string_contants.dart';
import 'package:northshore_nanny_flutter/app/utils/app_utils.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRHelper {
  String tag = "socket";

  static final SignalRHelper singleton = SignalRHelper._internal();

  factory SignalRHelper() => singleton;

  SignalRHelper._internal();

  late HubConnection hubConnection;

  bool isConnected = false;
  bool isUserConnected = false;

  Future<void> init() async {
    var token = await Storage.getValue(StringConstants.token);
    log("access token :--->> $token");
    debugPrint("access token :--->> $token");

    try {
      if (token != null && token.isNotEmpty) {
        final String accessToken =
            token.split('Bearer').last.replaceAll(" ", "");

        log("access token :--->> $accessToken");
        hubConnection = HubConnectionBuilder()
            .withUrl(
              ApiUrls.socketUrl,
              options: HttpConnectionOptions(
                transport: HttpTransportType.WebSockets,
                skipNegotiation: true,
                logMessageContent: true,
                accessTokenFactory: () => Future.value(accessToken),
              ),
            )
            .withAutomaticReconnect()
            .build();

        await startConnection();
        initListeners();
      }
    } catch (e) {
      Utils.printLog("socket exception:--> $e");
    }
  }

  /// START CONNECTION
  Future<void> startConnection() async {
    log("start scoket connection called");
    log("hubconnectionn state:--->>${hubConnection.state}");

    try {
      log("hubconnectionn state try:--->>${hubConnection.state}");

      await hubConnection.start();
      isConnected = true;
      isUserConnected = true;
      log("hubconnectionn state try:--->>${hubConnection.state}");

      // Utils.printLog("Connected: ${hubConnection.connectionId}");
    } catch (e) {
      log("hubconnectionn state else:--->>${hubConnection.state}");
      debugPrint("Connection error: $e");
      isConnected = false;
      isUserConnected = false;
    }
  }

  void initListeners() {
    log("init listender");
    hubConnection.onreconnecting(({error}) {
      Utils.printLog("onConnectError $error");
      isConnected = false;
      isUserConnected = false;
    });

    hubConnection.onreconnected(({connectionId}) {
      Utils.printLog("onReconnected $connectionId");
      isConnected = true;
      isUserConnected = true;
    });
    hubConnection.onclose(({error}) {
      Utils.printLog('$tag onClose: $error');
      isUserConnected = false;
      isConnected = false;
      reconnect();
    });
  }

  /// RECONNECT USER
  void reconnect() async {
    if (!isConnected) {
      await startConnection();
    }
  }

  HubConnection getHubConnection() => hubConnection;

  /// DISCONNECT USER

  void disconnectUser() {
    hubConnection.stop();
    isConnected = false;
    isUserConnected = false;
  }
}
