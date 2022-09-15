import 'package:flutter/material.dart';
import '../model/course.dart';
import '../sqlite/dbhelper.dart';


class MyProvider extends ChangeNotifier {

   final DbHelper _helper  = DbHelper();
   var allCourses = [];
   var filteredCourse = [];
   Course _course =  Course.init();


   Course get course => _course;

  void setCourse(Course course){
    _course = course;
  }

  void getCourses() {
     _helper.allCourses().then((courses){
         allCourses = courses;
         filteredCourse = allCourses;
     });
     notifyListeners();
   }


   Future<int> deleteCourse(int id) async{
     return await _helper.delete(id);
   }

   Future<int> updateCourse(Course course) async{
     return await  _helper.courseUpdate(course);
   }


   Future<int> insertCourse(Course course) async{
      return await _helper.createCourse(course);
   }




}