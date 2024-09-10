import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
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

  List<Map> tasks=[];


  bool isbottomSheetshown=false;
  IconData fbIcon=Icons.edit;

  void changeIndex(int index){
    currentIndex =index;
    emit(AppChangeBottomNavBarState());
  }
  late Database database;

   void createDatabase()  {
      openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      print('Database created');

      await database.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT ,date TEXT, time TEXT, status TEXT )');
    }, onOpen: (database) {
       getDatafromDatabase(database).then((value) {
        
          tasks= value;
          print(tasks);
        emit(AppGetDataFromDatabaseState());
      });
      print('Database opened');
      
    }).then((value) {
      database=value;
      emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase({
  required String title,
  required String time,
  required String date,

   }) async {

   await database.transaction((txn)async {
     await txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new" )').then(
      (value) {
      print('$value inserted success !');
      emit(AppInsertDatabaseState());
getDatafromDatabase(database).then((value) {
        
          tasks= value;
          print(tasks);
        emit(AppGetDataFromDatabaseState());
      });

     }).catchError((error){ 
      print(error.toString());
     });
      return null;
    });
  }


Future<List<Map>> getDatafromDatabase(database)async{
  emit(AppGetDataFromDatabaseLoadingState());
return await database.rawQuery('SELECT * FROM Tasks');

}
void changeBottomSheetState({required bool isShow, required IconData icon}){
isbottomSheetshown=isShow;
fbIcon=icon;
emit(AppChangeBottomSheetState());

}

  }
