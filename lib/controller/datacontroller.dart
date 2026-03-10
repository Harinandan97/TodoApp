



import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../service/service.dart';

class TaskController extends GetxController {
  final TaskService _service = TaskService();

  var tasks = <Map<String, dynamic>>[].obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController taskIdController = TextEditingController();
  final TextEditingController taskId2Controller = TextEditingController();

  bool currentState = false;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  // FETCH TASKS
  void fetchTasks() async {
    tasks.value = await _service.fetchTasks();
  }

  // ADD TASK
  void addTask() async {
    if (titleController.text.isEmpty) return;
    await _service.addTask(titleController.text);
    titleController.clear();
    fetchTasks();
  }

  // DELETE TASK
  void deleteTask() async {
    if (taskIdController.text.isEmpty) return;
    await _service.deleteTask(taskIdController.text);
    taskIdController.clear();
    fetchTasks();
  }

  // TOGGLE TASK
  void toggleTask() async {
    if (taskId2Controller.text.isEmpty) return;
    await _service.toggleTask(taskId2Controller.text, currentState);
    fetchTasks();
  }
}