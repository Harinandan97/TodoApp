import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';
import 'RegisterPage.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  final ToDoController controller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: height * 0.04),

                const Text(
                  "Login Account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),

                SizedBox(height: height * 0.06),

                /// EMAIL
                CustomTextField(
                  Label: "Email",
                  controller: controller.emailController,
                ),

                SizedBox(height: height * 0.03),

                /// PASSWORD
                CustomTextField(
                  Label: "Password",
                  controller: controller.passwordController,
                ),

                SizedBox(height: height * 0.05),

                /// LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    txt: 'Login',
                    OnPressed: () async {
                      await controller.login();
                    },
                  ),
                ),

                SizedBox(height: height * 0.04),

                /// OR DIVIDER
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                SizedBox(height: height * 0.03),

                /// GOOGLE SIGN IN BUTTON
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(
                      Icons.g_mobiledata,
                      size: 30,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Continue with Google",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      await controller.signInWithGoogle();
                    },
                  ),
                ),

                SizedBox(height: height * 0.06),

                /// REGISTER TEXT
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Not registered yet?"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),

                SizedBox(height: height * 0.03),

                Center(
                  child: TextButton(
                    onPressed: () {
                      controller.emailController.clear();
                      controller.passwordController.clear();
                      Get.to(() => Register());
                    },
                    child: const Text(
                      "Create an Account",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

              ],
            ),
          ),
        ),
      ),
    );
  }
}