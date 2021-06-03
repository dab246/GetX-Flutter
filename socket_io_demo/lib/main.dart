import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_demo/presentation/bindings/main_bindings.dart';
import 'package:socket_io_demo/presentation/routes/app_pages.dart';
import 'package:socket_io_demo/presentation/routes/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        initialBinding: MainBindings(),
        initialRoute: AppRoutes.LOGIN,
        getPages: AppPages.pages);
  }
}