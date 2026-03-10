import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/datacontroller.dart';
import '../../widget/_buildStatCard.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("My Tasks"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [

              /// TASK STATS
              Obx(() {
                int completed = controller.tasks
                    .where((task) => task["completed"] == true)
                    .length;

                return Row(
                  children: [

                    /// TOTAL TASK CARD
                    Expanded(
                      child: StatCard(title:
                      "Total Tasks",
                        value: controller.tasks.length.toString(),
                        color:Colors.blue,
                      ),
                    ),

                    SizedBox(width: width * 0.03),

                    /// COMPLETED TASK CARD
                    Expanded(
                      child: StatCard(
                        title: "Completed",
                        value: completed.toString(),
                        color: Colors.green,
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: height * 0.03),

              /// ADD TASK FIELD
              Row(
                children: [

                  Expanded(
                    child: TextField(
                      controller: controller.titleController,
                      decoration: InputDecoration(
                        hintText: "Enter new task...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.03),

                  /// ADD BUTTON
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(width * 0.04),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (controller.titleController.text.isNotEmpty) {
                        controller.addTask();
                      }
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              ),

              SizedBox(height: height * 0.03),

              /// TASK LIST
              Expanded(
                child: Obx(() {
                  if (controller.tasks.isEmpty) {
                    return const Center(
                      child: Text(
                        "No tasks yet 😴\nAdd a task to get started!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.tasks.length,
                    itemBuilder: (context, index) {
                      final task = controller.tasks[index];

                      return Card(
                        margin: EdgeInsets.only(bottom: height * 0.015),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ListTile(

                          leading: Checkbox(
                            value: task["completed"],
                            onChanged: (value) {
                              controller.taskId2Controller.text = task["id"];
                              controller.currentState = task["completed"];
                              controller.toggleTask();
                            },
                          ),

                          title: Text(
                            task["title"],
                            style: TextStyle(
                              decoration: task["completed"]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: task["completed"]
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),

                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              controller.taskIdController.text = task["id"];
                              controller.deleteTask();
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}