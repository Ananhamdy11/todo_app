import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/archieved_tasks_view_body.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/done_tasks_view_body.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/new_tasks_view_body.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntaialState());
  static AppCubit get(context)=> BlocProvider.of(context);
    int currentIndex = 0;

  List<Widget> screens = const [
    NewTasksViewBody(),
    DoneTasksViewBody(),
    ArchievedTasksViewBody()
  ];

  List<String> title = ['New Tasks', 'Done Tasks', 'Archieved Tasks'];

  void changeIndex(int index){
    currentIndex =index;
    emit(AppChangeBottomNavBarState());
  }

  }
