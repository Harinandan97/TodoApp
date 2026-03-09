import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_test/view/Authentication/LoginScreen.dart';

import '../view/bottomNavigationBar/bottomnavigationBar.dart';

class ToDoController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rxn<User> _user = Rxn<User>();

  User? get user => _user.value;

  RxInt currentIndex = 0.obs;


  String? userMail;
  @override
  void onInit() {
    super.onInit();
    startSplash();
    _user.bindStream(_auth.authStateChanges());

    loadLogin();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



 bottom (int index) {
  currentIndex.value = index;
  }

  void startSplash() {
    Timer(const Duration(seconds: 3), () {
      Get.off(() => Loginscreen());
    });
  }

  // REGISTER
  Future<void> register() async {
    try {

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user.value = userCredential.user;
      emailController.clear();
      passwordController.clear();

      await _saveLogin(email);

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Registration Failed");
    }
  }

  // LOGIN
  Future<void> login() async {
    try {

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user.value = userCredential.user;

      await _saveLogin(email);

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Login Failed");
    }
  }

  // LOGOUT
  Future<void> logout() async {

    await _auth.signOut();

    await _clearLogin();

    _user.value = null;
    emailController.clear();
    passwordController.clear();
  }

  // SAVE LOGIN
  Future<void> _saveLogin(String email) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
  }

  // CLEAR LOGIN
  Future<void> _clearLogin() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  // LOAD LOGIN
  Future<void> loadLogin() async {

    final prefs = await SharedPreferences.getInstance();

    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      userMail = prefs.getString('email');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}