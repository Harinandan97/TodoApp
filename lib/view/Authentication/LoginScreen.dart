import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';

import '../bottomNavigationBar/bottomnavigationBar.dart';
import '../home/home.dart';
import 'RegisterPage.dart';

class Loginscreen extends StatelessWidget {

  Loginscreen({super.key});

  final ToDoController controller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 25, left: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "LoginAccount",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 100),

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(Hint: "edit to do list",
                    Label: "Email",
                    controller: controller.emailController,
                  ),
                ),
              ),

              const SizedBox(height: 80),

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(Hint: "sharedPreference",
                    Label: "Password",
                    controller: controller.passwordController,
                  ),
                ),
              ),

              const SizedBox(height: 100),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomButton(
                  txt: 'Login',
                  OnPressed: () async {

                    await controller.login();

                    if (controller.user != null) {
                     Get.off(() => MainScreen());
                      print("doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                    }

                  },
                ),
              ),

              const SizedBox(height: 100),

              Row(
                children: const [
                  Expanded(child: Divider(thickness: 3, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Not Register Yet?"),
                  ),
                  Expanded(child: Divider(thickness: 3, color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 70),

              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    onPressed: () {
                     controller.emailController.clear();
                     controller. passwordController.clear();
                      Get.to(() => Register());
                    },
                    child: const Text(
                      "Create An Account",
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}