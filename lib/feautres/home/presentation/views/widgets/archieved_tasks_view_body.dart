import 'package:flutter/material.dart';

class ArchievedTasksViewBody extends StatelessWidget {
  const ArchievedTasksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Row(
    children: [
      CircleAvatar(
        radius: 40,
        child: Text('2:00 pm'),
      ),
      SizedBox(width: 20,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'task title',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            '2 April,2024',
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      )
    ],
    ) ;
 
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