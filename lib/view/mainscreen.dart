import 'package:flutter/material.dart';
import 'package:fluttertask/view/dashboard.dart';
import 'package:fluttertask/view/loginscreen.dart';
import 'package:get/get.dart';

import '../controller/authcontroller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var authcontroller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return

        // FutureBuilder(
        //   future: authcontroller.checkLogin(),
        //   builder: (context, snapshot) =>
        //       snapshot.connectionState == ConnectionState.waiting
        //           ? Center(
        //               child: CircularProgressIndicator(),
        //             )
        //           : snapshot.data!
        //               ? UserDashboard(authController: authcontroller)
        //               : AuthView(
        //                   authController: authcontroller,
        //                 ),
        // );

        Obx(() => authcontroller.loggedIn.value
            ? UserDashboard(authController: authcontroller)
            : AuthView(
                authController: authcontroller,
              ));
  }
}
