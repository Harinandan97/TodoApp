import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/datacontroller.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Your Tasks (${controller.tasks.length})",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            const SizedBox(height: 10),
            /// ADD TASK FIELD
            CustomTextField(
              Label: "Add Task",

              controller: controller.titleController,

            ),

            const SizedBox(height: 10),

            /// ADD BUTTON
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                OnPressed: () {
                  if (controller.titleController.text.isNotEmpty) {
                    controller.addTask();
                  }
                }, txt: 'Add task',

              ),
            ),

            const SizedBox(height: 20),

            /// TASK LIST
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {

                    final task = controller.tasks[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,

                        leading: Checkbox(
                          value: task["completed"],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            controller.taskId2Controller.text = task["id"];
                            controller.currentState = task["completed"];
                            controller.toggleTask();
                          },
                        ),

                        title: Text(
                          task["title"],
                          style: TextStyle(
                            fontSize: 16,
                            decoration: task["completed"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: task["completed"] ? Colors.grey : Colors.black,
                          ),
                        ),

                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            controller.taskIdController.text = task["id"];
                            controller.deleteTask();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}