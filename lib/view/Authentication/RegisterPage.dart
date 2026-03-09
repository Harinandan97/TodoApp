import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';
import 'LoginScreen.dart';


class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ToDoController());

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          "Structure begins from now",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Image.asset("assets/images/img.png"),
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    Label: "Email",
                    controller: controller.emailController,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "The structured plan starts from this point",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 35),

                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextField(
                    Label: "Password",
                    controller: controller.passwordController,
                  ),
                ),

                const SizedBox(height: 100),

                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomButton(
                    txt: "Register",
                    OnPressed: () async {

                      await controller.register();

                      if (controller.user != null) {

                        Get.off(() => Loginscreen());

                      }

                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}