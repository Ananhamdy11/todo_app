
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/core/helpers/constants.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/archieved_tasks_view_body.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/done_tasks_view_body.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/new_tasks_view_body.dart';


class HomeView extends StatelessWidget
{
 
  int currentIndex = 0;
  late Database database;
  var titleControllr= TextEditingController();
  var timeControllr= TextEditingController();
  var dateControllr= TextEditingController();

  var scaffoldKey= GlobalKey<ScaffoldState>();
  var formKey= GlobalKey<FormState>();


  bool isbottomSheetshown=false;
  IconData fbIcon=Icons.edit;
  List<Widget> screens = const [
    NewTasksViewBody(),
    DoneTasksViewBody(),
    ArchievedTasksViewBody()
  ];

  List<String> title = ['New Tasks', 'Done Tasks', 'Archieved Tasks'];

  Future<String> getName() async {
    return "Ahmed Ali";
  }

  void createDatabase() async {
     database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      print('Database created');

      await database.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT ,date TEXT, time TEXT, status TEXT )');
    }, onOpen: (database) {
      getDatafromDatabase(database).then((value) {
        tasks=value;
        print(tasks);
      });
      print('Database opened');
      
    });
  }

  Future insertToDatabase({
  required String title,
  required String time,
  required String date,

   }) async {

  return await database.transaction((txn)async {
     await txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES("$title","$date","$time","new" )').then(
      (value) {
      print('$value inserted success !');
     }).catchError((error){ 
      print(error.toString());
     });
      return null;
    });
  }


Future<List<Map>> getDatafromDatabase(database)async{
return await database.rawQuery('SELECT * FROM Tasks');
}

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        title: Text(
          title[currentIndex],
        ),
      ),
      body:tasks.isEmpty? const Center(child: CircularProgressIndicator()) : screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(isbottomSheetshown){
            if(formKey.currentState!.validate()){
              insertToDatabase(title:titleControllr.text ,
               time:timeControllr.text ,
                date:dateControllr.text,
              ).then((value) {

            getDatafromDatabase(database).then((value) {
                              Navigator.pop(context);

            //   setState(() {
            // isbottomSheetshown=false;
            //     fbIcon=Icons.edit;
            //     tasks=value;
            //   print(tasks);

            //   });
        
      });
           
              });
           
            }
            

          }else{
            scaffoldKey.currentState!.showBottomSheet((context) => Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(22),
              
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  TextFormField(
                    controller: titleControllr,
                    keyboardType: TextInputType.text,
                    validator: ( value){
                      if(value!.isEmpty){
                        return 'title is required ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "title",
                      prefix:Icon(Icons.title)              
                    ),
                  ),
                               
                  const SizedBox(height: 15,),
                                TextFormField(
                    controller: timeControllr,
                    keyboardType: TextInputType.datetime,
                    onTap: (){
                      showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
                        (value) {
                          timeControllr.text=value!.format(context);
                          print(value.format(context));
                        }
                      );
                    },
                    validator: ( value){
                      if(value!.isEmpty){
                        return 'time is required ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "time",
                      prefix:Icon(Icons.watch_later_outlined)              
                    ),
                  ),
                       const SizedBox(height: 15,) ,             
                                 TextFormField(
                    controller: dateControllr,
                    keyboardType: TextInputType.datetime,
                    onTap: (){
                      showDatePicker(context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2024-10-03'),
                      initialDate:DateTime.now(),
                      ).then((value) {
                        print(DateFormat.yMMMd().format(value!));
                        dateControllr.text=DateFormat.yMMMd().format(value);
                      });
                    },
                    validator: ( value){
                      if(value!.isEmpty){
                        return 'date is required ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "date",
                      prefix:Icon(Icons.calendar_view_day_rounded)              
                    ),
                  ),
                  const SizedBox(height: 15,),
                                     
                  ],
                ),
              ),
            ),elevation: 15).closed.then((value) {
            isbottomSheetshown=false;
            // setState(() {
            //   fbIcon=Icons.edit;
            // });
            })
          
           
            ;
          
          isbottomSheetshown=true;
            // setState(() {
            //   fbIcon=Icons.add;
            // });

          }

         

          // insertToDatabase();
          // getName().then((value) {
          //   print(value);
          //   print('osama');
          // }).catchError((error) {
          //   print("error ${error.toString()}");
          // });
          // try {
          //    var name= await getName();
          // print(name);

          // } catch (e) {
          //   print('error ${e.toString()}');
          // }
        },
        child:  Icon(fbIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            // setState(() {});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline), label: 'done'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: 'archived')
          ]),
    );
  }
  
}


// 1- create database
// 2- create tables
// 3-open database
// 4- insert to database
// 5- get from database
// 6-  update in database
// 7- delete from database

