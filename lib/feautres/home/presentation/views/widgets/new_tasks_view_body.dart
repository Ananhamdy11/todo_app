import 'package:flutter/material.dart';
import 'package:todo_app/core/helpers/constants.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/task_item_widget.dart';

class NewTasksViewBody extends StatelessWidget {
  const NewTasksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context,index){
        return BuildTaskItem(model: tasks[index],);
      },
     separatorBuilder:(context,index)=> Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
         
     ) ,
      itemCount: tasks.length,
      );
 
  }
}
