import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapppractice/Data/task_repository.dart';

class NewTaskScreenCubit extends Cubit<void> {
  NewTaskScreenCubit() : super(0);
  var taskRepo = TaskRepository();

  Future<void> save(String taskName) async {
    await taskRepo.save(taskName);
  }
}
