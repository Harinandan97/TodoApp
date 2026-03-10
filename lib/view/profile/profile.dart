import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controller/controller.dart';
import '../../widget/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ToDoController());
    final user = auth.currentUser;

    /// MEDIAQUERY
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            children: [

              SizedBox(height: height * 0.03),

              /// PROFILE IMAGE
              CircleAvatar(
                radius: width * 0.15,
                backgroundColor: Colors.black,
                child: Text(
                  user?.email?[0].toUpperCase() ?? "",
                  style: TextStyle(
                    fontSize: width * 0.08,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: height * 0.03),

              /// EMAIL
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    size: width * 0.07,
                  ),
                  title: Text(
                    "Email",
                    style: TextStyle(fontSize: width * 0.045),
                  ),
                  subtitle: Text(
                    user?.email ?? "No email",
                    style: TextStyle(fontSize: width * 0.04),
                  ),
                ),
              ),

              SizedBox(height: height * 0.015),

              // /// USER ID
              // Card(
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.badge,
              //       size: width * 0.07,
              //     ),
              //     title: Text(
              //       "User ID",
              //       style: TextStyle(fontSize: width * 0.045),
              //     ),
              //     subtitle: Text(
              //       user?.uid ?? "Unknown",
              //       style: TextStyle(fontSize: width * 0.04),
              //     ),
              //   ),
              // ),

             // SizedBox(height: height * 0.05),

              /// LOGOUT BUTTON
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  txt: 'Logout',
                  clr: Colors.red,
                  OnPressed: () async {
                    controller.logout();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}