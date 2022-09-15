import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/course.dart';
import '../provider/my_provider.dart';

class UpdateCourse extends StatefulWidget {
  const UpdateCourse({super.key});


  @override
  UpdateCourseState createState() => UpdateCourseState();
}

class UpdateCourseState extends State<UpdateCourse> {
  TextEditingController teName = TextEditingController();
  TextEditingController teContent = TextEditingController();
  TextEditingController tePrice = TextEditingController();
  @override
  void initState() {
    super.initState();
    teName.text = Provider.of<MyProvider>(context, listen: false).course.name!;
    teContent.text = Provider.of<MyProvider>(context, listen: false).course.content!;
    tePrice.text = Provider.of<MyProvider>(context, listen: false).course.price.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Course'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            TextField(controller: teName,),
            TextField(maxLines: null,controller: teContent,),
            TextField(keyboardType: TextInputType.number,controller: tePrice,),
            ElevatedButton(child: const Text('Save'),
              onPressed: ()async{
              var updatedCourse = Course({
                'id': Provider.of<MyProvider>(context, listen: false).course.id,
                'name': teName.text,
                'content':teContent.text,
                'price' : int.parse(tePrice.text),
              });
              Provider.of<MyProvider>(context, listen: false).updateCourse(updatedCourse).then((response) {
                debugPrint("data updated ================== $response");
                Provider.of<MyProvider>(context, listen: false).getCourses();
              });
              },),
          ],
        ),
      ),

    );
  }
}