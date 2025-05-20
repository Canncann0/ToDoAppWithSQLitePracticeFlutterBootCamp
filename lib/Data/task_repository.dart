import 'package:todoapppractice/Data/database_helper.dart';
import 'package:todoapppractice/Data/task_model.dart';

class TaskRepository {
  Future<void> save(String taskName) async {
    var db = await DatabaseHelper.veritabaniErisim();
    var newTask = <String, dynamic>{};
    newTask["task_name"] = taskName;
    newTask["isActive"] = 0;

    await db.insert("tasks", newTask);
  }

  Future<List<TaskModel>> loadTasks() async {
    var db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> list = await db.rawQuery("SELECT * FROM tasks ");
    return List.generate(list.length, (index) {
      var row = list[index];
      var id = row["id"];
      var taskName = row["task_name"];
      var isActive = row["isActive"];
      return TaskModel(id: id, taskName: taskName, isActive: isActive);
    });
  }

  Future<void> updateTaskStatus(int id, int newStatus) async {
    var db = await DatabaseHelper.veritabaniErisim();
    await db.update(
      "tasks",
      {"isActive": newStatus},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> update(int id, String taskName) async {
    var db = await DatabaseHelper.veritabaniErisim();
    var updatedTask = <String, dynamic>{};
    updatedTask["task_name"] = taskName;

    await db.update("tasks ", updatedTask, where: "id=?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    var db = await DatabaseHelper.veritabaniErisim();
    await db.delete("tasks", where: "id=?", whereArgs: [id]);
  }

  Future<List<TaskModel>> search(String searchText) async {
    var db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> list = await db.rawQuery(
      "SELECT * FROM tasks WHERE task_name LIKE '%$searchText%' ",
    );

    return List.generate(list.length, (index) {
      var row = list[index];
      var id = row["id"];
      var taskName = row["task_name"];
      var isActive = row["isActive"];

      return TaskModel(id: id, taskName: taskName, isActive: isActive);
    });
  }
}
