import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/my_provider.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Details'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Course name : ${Provider.of<MyProvider>(context, listen: false).course.name!}" ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const SizedBox(height: 20,),
              Text("Course content : \n${Provider.of<MyProvider>(context, listen: false).course.content!}" ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const SizedBox(height: 20,),
              Text("Course price : ${Provider.of<MyProvider>(context, listen: false).course.price!}" ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          ),
        ),
      ),


    );
  }
}