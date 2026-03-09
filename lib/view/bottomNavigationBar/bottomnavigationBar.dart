import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';
import '../home/home.dart';
import '../profile/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = Get.put(ToDoController());
  //int currentIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(()=> pages[controller.currentIndex.value]),

      bottomNavigationBar: Obx(
        ()=> BottomNavigationBar(
          currentIndex:controller.currentIndex.value,

          onTap: controller.bottom,

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),

          ],
        ),
      ),
    );
  }
}