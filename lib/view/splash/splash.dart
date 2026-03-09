import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final controller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {

    controller.startSplash();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF758F8E),
              const Color(0xFF758F8E),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.task_alt,
              size: 100,
              color: Colors.white,
            ),

            SizedBox(height: 20),

            Text(
              "Todo App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Organize your tasks",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 40),

            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}