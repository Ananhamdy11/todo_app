import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'done_tasks_state.dart';

class DoneTasksCubit extends Cubit<DoneTasksState> {
  DoneTasksCubit() : super(DoneTasksInitial());
}
