import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/feautres/home/presentation/managers/app_cubit/app_cubit.dart';

class BuildTaskItem extends StatelessWidget {
  const BuildTaskItem({
    super.key,
    required this.model,
  });
  final Map model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${model['date']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
          onPressed: () {
            AppCubit.get(context).updateData(status: 'done', id: model['id']);
          },
           icon: Icon(Icons.check_box),

           ),
            IconButton(
          onPressed: () {
            AppCubit.get(context).updateData(status: 'archived', id:model['id']);
          },
           icon: Icon(Icons.archive),

           ),
        ],
      ),
    );
  }
}
