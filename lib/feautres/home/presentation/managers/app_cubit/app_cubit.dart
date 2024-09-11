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

  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];


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
       getDatafromDatabase(database);
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
 getDatafromDatabase(database);

     }).catchError((error){ 
      print(error.toString());
     });
      return null;
    });
  }

void updateData({required String status, required int id}) async{
   database.rawUpdate(
    'UPDATE taska SET status = ?, WHERE id = ?',
    ['$status', id ]).then((value)
     {
      emit(AppUpdateDatabaseState());
    }
    ) ;

}

void getDatafromDatabase(database){
  emit(AppGetDataFromDatabaseLoadingState());
 database.rawQuery('SELECT * FROM Tasks').then((value) {
        

          value.forEach((element) {
            if(element['status']=='new' ){
              newTasks.add(element);
            }else if(element['status']=='done'){
              doneTasks.add(element);
            }else{
              archivedTasks.add(element);
            }
          });

        emit(AppGetDataFromDatabaseState());
      });

}

void changeBottomSheetState({required bool isShow, required IconData icon}){
isbottomSheetshown=isShow;
fbIcon=icon;
emit(AppChangeBottomSheetState());

 }
}
