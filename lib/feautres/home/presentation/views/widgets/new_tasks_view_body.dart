import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feautres/home/presentation/managers/app_cubit/app_cubit.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/no_tasks_widget.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/task_item_widget.dart';
class NewTasksViewBody extends StatelessWidget {
  const NewTasksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,satate){

      },
      builder: (context,state){
        var tasks=AppCubit.get(context).newTasks;
        if(tasks.isEmpty){
          return const NoTasksWidget();
        
        }else{
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
    );}}
    );
 
  }
}
