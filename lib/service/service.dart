import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://rootcause-iq-default-rtdb.firebaseio.com/",
    ),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser!.uid;

  // FETCH TASKS
  Future<List<Map<String, dynamic>>> fetchTasks() async {
    try {
      final response = await dio.get("tasks/$userId.json");

      if (response.data == null) return [];

      Map data = response.data;
      List<Map<String, dynamic>> loadedTasks = [];

      data.forEach((key, value) {
        loadedTasks.add({
          "id": key,
          "title": value["title"],
          "completed": value["completed"]
        });
      });

      return loadedTasks;

    } catch (e) {
      print("Fetch Error: $e");
      return [];
    }
  }

  // ADD TASK
  Future<void> addTask(String title) async {
    try {
      await dio.post(
        "tasks/$userId.json",
        data: {"title": title, "completed": false},
      );
    } catch (e) {
      print("Add Error: $e");
    }
  }

  // DELETE TASK
  Future<void> deleteTask(String taskId) async {
    try {
      await dio.delete("tasks/$userId/$taskId.json");
    } catch (e) {
      print("Delete Error: $e");
    }
  }

  // TOGGLE TASK
  Future<void> toggleTask(String taskId, bool currentState) async {
    try {
      await dio.patch(
        "tasks/$userId/$taskId.json",
        data: {"completed": !currentState},
      );
    } catch (e) {
      print("Toggle Error: $e");
    }
  }
}