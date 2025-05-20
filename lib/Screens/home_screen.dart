import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapppractice/Cubits/home_screen_cubit.dart';
import 'package:todoapppractice/Data/task_model.dart';
import 'package:todoapppractice/Screens/new_task_screen.dart';
import 'package:todoapppractice/Screens/update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        title: Text(
          "Görevlerim",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade900,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  height: 44,
                  child: CupertinoSearchTextField(
                    itemColor: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    placeholderStyle: TextStyle(color: Colors.white),
                    style: TextStyle(color: Colors.white),
                    onChanged: (searchText) {
                      context.read<HomeScreenCubit>().search(searchText);
                    },
                  ),
                ),
              ),
            ),
            BlocBuilder<HomeScreenCubit, List<TaskModel>>(
              builder: (context, taskList) {
                if (taskList.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        var task = taskList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => UpdateScreen(taskModel: task),
                              ),
                            ).then((_) {
                              context.read<HomeScreenCubit>().loadTasks();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              color: Colors.grey.shade800,

                              child: ListTile(
                                contentPadding: EdgeInsets.all(4),
                                iconColor: Colors.white,
                                textColor: Colors.white,
                                title: Text(
                                  task.taskName,
                                  style: GoogleFonts.poppins(
                                    color:
                                        task.isActive == 1
                                            ? Colors.limeAccent
                                            : Colors.white,
                                    decoration:
                                        task.isActive == 1
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                    decorationThickness: 2,
                                  ),
                                ),
                                leading: IconButton(
                                  onPressed: () {
                                    context
                                        .read<HomeScreenCubit>()
                                        .toggleTaskStatus(task);
                                  },
                                  icon: Icon(
                                    task.isActive == 1
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color:
                                        task.isActive == 1
                                            ? Colors.limeAccent
                                            : Colors.white,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.grey.shade900,
                                        content: Text(
                                          "Are you sure to delete ? ${task.taskName}",
                                        ),
                                        action: SnackBarAction(
                                          label: "Yes",
                                          textColor: Colors.limeAccent,
                                          onPressed: () {
                                            context
                                                .read<HomeScreenCubit>()
                                                .delete(task.id);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.close),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text(
                        "Liste Boş",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.limeAccent,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.limeAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTaskScreen()),
          ).then((_) {
            context.read<HomeScreenCubit>().loadTasks();
          });
        },
        child: Icon(Icons.add, color: Colors.grey.shade900),
      ),
    );
  }
}
