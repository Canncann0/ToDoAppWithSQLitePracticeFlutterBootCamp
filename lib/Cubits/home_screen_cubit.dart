import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapppractice/Data/task_model.dart';
import 'package:todoapppractice/Data/task_repository.dart';

class HomeScreenCubit extends Cubit<List<TaskModel>> {
  HomeScreenCubit() : super(<TaskModel>[]);
  var taskRepo = TaskRepository();

  Future<void> loadTasks() async {
    var list = await taskRepo.loadTasks();
    emit(list);
  }

  Future<void> toggleTaskStatus(TaskModel task) async {
    int newStatus = task.isActive == 1 ? 0 : 1;
    await taskRepo.updateTaskStatus(task.id, newStatus);
    await loadTasks();
  }

  Future<void> delete(int id) async {
    await taskRepo.delete(id);
    await loadTasks();
  }

  Future<void> search(String searchText) async {
    var list = await taskRepo.search(searchText);
    emit(list);
  }
}
