import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapppractice/Data/task_repository.dart';

class UpdateScreenCubit extends Cubit<void> {
  UpdateScreenCubit() : super(0);

  var taskRepo = TaskRepository();

  Future<void> update(int id, String taskName) async {
    await taskRepo.update(id, taskName);
  }
}
