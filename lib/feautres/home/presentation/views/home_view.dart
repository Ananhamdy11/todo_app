import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/feautres/home/presentation/managers/app_cubit/app_cubit.dart';

class HomeView extends StatelessWidget {
  var titleControllr = TextEditingController();
  var timeControllr = TextEditingController();
  var dateControllr = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  Future<String> getName() async {
    return "Ahmed Ali";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentIndex]),
            ),
            body: state is AppGetDataFromDatabaseLoadingState 
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isbottomSheetshown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleControllr.text,
                        time: timeControllr.text,
                        date: dateControllr.text);

                    //         insertToDatabase(title:titleControllr.text ,
                    //          time:timeControllr.text ,
                    //           date:dateControllr.text,
                    //         ).then((value) {

                    //       getDatafromDatabase(database).then((value) {
                    //                         Navigator.pop(context);

                    //       //   setState(() {
                    //       // isbottomSheetshown=false;
                    //       //     fbIcon=Icons.edit;
                    //       //     tasks=value;
                    //       //   print(tasks);

                    //       //   });

                    // });

                    //         });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) => Container(
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'title is required ';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "title",
                                            prefix: Icon(Icons.title)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: timeControllr,
                                        keyboardType: TextInputType.datetime,
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timeControllr.text =
                                                value!.format(context);
                                            print(value.format(context));
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'time is required ';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "time",
                                            prefix: Icon(
                                                Icons.watch_later_outlined)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: dateControllr,
                                        keyboardType: TextInputType.datetime,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('2024-10-03'),
                                            initialDate: DateTime.now(),
                                          ).then((value) {
                                            print(DateFormat.yMMMd()
                                                .format(value!));
                                            dateControllr.text =
                                                DateFormat.yMMMd()
                                                    .format(value);
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'date is required ';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "date",
                                            prefix: Icon(Icons
                                                .calendar_view_day_rounded)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 15)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                    // cubit.isbottomSheetshown=false;
                    // setState(() {
                    //   fbIcon=Icons.edit;
                    // });
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);

                  //  cubit.isbottomSheetshown=true;
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
              child: Icon(cubit.fbIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'archived')
                ]),
          );
        },
      ),
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

