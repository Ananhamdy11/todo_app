import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feautres/home/presentation/managers/app_cubit/app_cubit.dart';
import 'package:todo_app/feautres/home/presentation/views/widgets/task_item_widget.dart';

class ArchievedTasksViewBody extends StatelessWidget {
  const ArchievedTasksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context,satate){

      },
      builder: (context,state){
        var tasks=AppCubit.get(context).archivedTasks;
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
    );},
    );
 
  }
}



// Widget BuildTaskIte (Map model)=>  Padding
// (padding: EdgeInsets.all(8),
// child: Row(
//     children: [
//       CircleAvatar(
//         radius: 40,
//         child: Text('${model['time']}'),
//       ),
//       SizedBox(width: 20,),
//       Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//     'task title',
//     style: TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.bold
//     ),
//           ),
//           Text(
//     '2 April,2024',
//     style: TextStyle(
//       color: Colors.grey,
//     ),
//           )
//         ],
//       )
//     ],
//     ) ,);