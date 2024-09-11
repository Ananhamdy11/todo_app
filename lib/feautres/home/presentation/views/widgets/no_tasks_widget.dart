import 'package:flutter/material.dart';

class NoTasksWidget extends StatelessWidget {
  const NoTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text('No Tasks Yet , Please Add Some Tasks !',style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ),)
        ],
      ),
    );
  }
}



