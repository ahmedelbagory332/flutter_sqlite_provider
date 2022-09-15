import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/my_provider.dart';
import '../sqlite/dbhelper.dart';
import '../model/course.dart';


class NewCourse extends StatefulWidget {
  const NewCourse({super.key});

  @override
  NewCourseState createState() => NewCourseState();
}

class NewCourseState extends State<NewCourse> {
  String name = "", content = "";
  int price = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Course'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Enter Course name'
                  ),
                  onChanged: (value){
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  maxLines: 10,
                  decoration: const InputDecoration(
                      hintText: 'Enter Course Content'
                  ),
                  onChanged: (value){
                    setState(() {
                      content = value;
                    });
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter Course price'
                  ),
                  onChanged: (value){
                    setState(() {
                      price = int.parse(value);
                    });
                  },
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: ()async{
                    Provider.of<MyProvider>(context, listen: false).insertCourse(Course({'name':name,'content':content,'price':price})).then((response) {
                      debugPrint("data saved ================== $response");
                      Provider.of<MyProvider>(context, listen: false).getCourses();
                    });

                    },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}