import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/utils/config/communication_config.dart';
import 'package:northshore_nanny_flutter/app/utils/enums.dart';

class EnvConfig {
  const EnvConfig({
    required this.appTitle,
    this.theme,
    this.themeMode,
    required this.appFlavor,
    this.commConfig,
  });

  final String appTitle;
  final ThemeData? theme;
  final ThemeMode? themeMode;
  final AppFlavor appFlavor;
  final CommunicationConfig? commConfig;
}
