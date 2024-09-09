import 'package:flutter/material.dart';

class BuildTaskItem extends StatelessWidget {
  const BuildTaskItem({
    super.key, required this.model,
    
  });
final Map model;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text('${model['time']}'),
        ),
       const SizedBox(width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
      '${model['title']}',
      style:const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),
            ),
            Text(
      '${model['date']}',
      style:const TextStyle(
        color: Colors.grey,
      ),
            )
          ],
        )
      ],
      ),
    );
  }
}

