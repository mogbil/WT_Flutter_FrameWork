// ************************************************************
// * WT Flutter FrameWork
// * @version : 1.0
// * @copyright : 2024 WondTech for Integrated Digital Solutions
// * @link : http://www.wondtech.com
// ************************************************************

import 'package:flutter/material.dart';

// ── Copy these imports from WT Framework package ──────────
import '../lib/wt.dart';
// ─────────────────────────────────────────────────────────

import 'lib/controllers/home_controller.dart';
import 'lib/controllers/not_found_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Start Session
  await WtSession.init();

  // Initialize Config (equivalent to wt_config.php)
  WtConfig.init(
    const WtConfig(
      appName: 'WT Framework App',
      baseUrl: 'https://jsonplaceholder.typicode.com',
      secretKey: 'wondtech_secret_2024',
      debugMode: true,
    ),
  );

  runApp(
    WtApp(
      config: WtConfig.instance,
      router: WtRouter(
        initialRoute: '/',

        // Define routes — equivalent
        routes: [
          WtRoute(
            path: '/',
            builder: (s) => HomeController(s),
          )
        ],
        notFoundPage: (ctx, s) => NotFoundController(s).render(ctx),
      ),
    ),
  );
}
