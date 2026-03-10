import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



 bottom (int index) {
  currentIndex.value = index;
  }

  void startSplash() {
    Timer(const Duration(seconds: 3), () {

      if (_auth.currentUser != null) {
        Get.off(() => MainScreen());
      } else {
        Get.off(() => Loginscreen());
      }
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
      Get.off(() => MainScreen());


    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Login Failed");
    }
  }

  // LOGOUT
  Future<void> logout() async {

    await _auth.signOut();

    _user.value = null;
    emailController.clear();
    passwordController.clear();
    currentIndex.value = 0;

    Get.off(() => Loginscreen());
  }
///Google signIn
  Future<UserCredential?> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser =
    await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Get.off(() => MainScreen());
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }



  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}