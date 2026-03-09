import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controller/controller.dart';
import '../../widget/custom_button.dart';
import '../Authentication/LoginScreen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
final controller = Get.put(ToDoController());

    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 20),

            /// PROFILE IMAGE
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            /// USER EMAIL
            Card(
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text("Email"),
                subtitle: Text(user?.email ?? "No email"),
              ),
            ),

            const SizedBox(height: 10),

            /// USER ID
            Card(
              child: ListTile(
                leading: const Icon(Icons.badge),
                title: const Text("User ID"),
                subtitle: Text(user?.uid ?? "Unknown"),
              ),
            ),

            const SizedBox(height: 30),

            /// LOGOUT BUTTON

            CustomButton(txt: 'Logout',clr: Colors.red,OnPressed: () async {

              controller.logout();

              Get.off(() => Loginscreen());

            })

          ],
        ),
      ),
    );
  }
}