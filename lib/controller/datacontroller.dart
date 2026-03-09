import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskController extends GetxController {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://rootcause-iq-default-rtdb.firebaseio.com/",
    ),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var tasks = <Map<String, dynamic>>[].obs;

  String get userId => _auth.currentUser!.uid;

  bool currentState = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController taskIdController = TextEditingController();
  final TextEditingController taskId2Controller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  // FETCH TASKS
  Future<void> fetchTasks() async {
    try {

      final response = await dio.get("tasks/$userId.json");

      if (response.data == null) {
        tasks.clear();
        return;
      }

      Map data = response.data;

      List<Map<String, dynamic>> loadedTasks = [];

      data.forEach((key, value) {
        loadedTasks.add({
          "id": key,
          "title": value["title"],
          "completed": value["completed"]
        });
      });

      tasks.value = loadedTasks;

    } catch (e) {
      print(e);
    }
  }

  // ADD TASK
  Future<void> addTask() async {

    try {

      await dio.post(
        "tasks/$userId.json",
        data: {
          "title": titleController.text,
          "completed": false,
        },
      );

      titleController.clear();

      fetchTasks();

    } catch (e) {
      print(e);
    }
  }

  // DELETE TASK
  Future<void> deleteTask() async {

    try {

      await dio.delete(
        "tasks/$userId/${taskIdController.text}.json",
      );

      taskIdController.clear();

      fetchTasks();

    } catch (e) {
      print(e);
    }
  }

  // TOGGLE TASK
  Future<void> toggleTask() async {

    try {

      await dio.patch(
        "tasks/$userId/${taskId2Controller.text}.json",
        data: {
          "completed": !currentState
        },
      );

      fetchTasks();

    } catch (e) {
      print(e);
    }
  }
}