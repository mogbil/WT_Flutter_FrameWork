// ************************************************************
// * WT Flutter FrameWork
// * @version : 1.0
// * @copyright : 2024 WondTech for Integrated Digital Solutions
// * @link : http://www.wondtech.com
// ************************************************************

import 'package:flutter/material.dart';

class WtConfig {
  final String appName;
  final String baseUrl;
  final String secretKey;
  final ThemeData? theme;
  final bool debugMode;

  const WtConfig({
    required this.appName,
    required this.baseUrl,
    required this.secretKey,
    this.theme,
    this.debugMode = false,
  });

  static WtConfig? _instance;

  static void init(WtConfig config) {
    _instance = config;
  }

  static WtConfig get instance {
    assert(_instance != null, 'WtConfig not initialized. Call WtConfig.init() first.');
    return _instance!;
  }
}
