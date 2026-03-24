// ************************************************************
// * WT Flutter FrameWork
// * @version : 1.0
// * @copyright : 2024 WondTech for Integrated Digital Solutions
// * @link : http://www.wondtech.com
// ************************************************************

import 'package:flutter/material.dart';
import '../../lib/libs/mvc/wt_controller.dart';
import '../../lib/libs/mvc/wt_view.dart';

class NotFoundController extends WtController {
  NotFoundController(super.settings);

  @override
  WtView view(BuildContext context) {
    final v = NotFoundView();
    v.assign('title', '404 Not Found');
    v.assign('onHome', () => redirect(context, '/'));
    return v;
  }
}

class NotFoundView extends WtView {
  @override
  Widget build(BuildContext context) {
    final onHome = get<Function>('onHome');

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('404',
                style: TextStyle(
                    color: Color(0xFF2980B9),
                    fontSize: 80,
                    fontWeight: FontWeight.bold)),
            const Text('Page Not Found',
                style: TextStyle(color: Colors.white, fontSize: 22)),
            const SizedBox(height: 8),
            Text('WT Framework — Route not defined',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.4), fontSize: 13)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => onHome?.call(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2980B9),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
