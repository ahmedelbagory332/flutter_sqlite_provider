import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/course.dart';

class DbHelper{

  static Database? _db ;


   Future<Database?> get db async {
   if(_db == null){
     _db = await _createDatabase();
     return _db;
   }else{
     return _db;
   }
  }

  _createDatabase() async{
    //define the path to the database
    String path = join(await getDatabasesPath(), 'course.db');
    Database myDb = await openDatabase(path,version: 1, onCreate: _createDb);
    return myDb;
  }

   _createDb(Database db, int v) async{
    //create tables
    await db.execute('create table courses(id integer primary key autoincrement, name varchar(50), content varchar(255), price integer)');

  }

  Future<int> createCourse(Course course) async{
    Database? myDb = await db;
    return myDb!.insert('courses', course.toMap());
  }


  Future<List> allCourses() async{
    Database? myDb = await db;
    return await  myDb!.query('courses');
  }

  Future<int> delete(int id) async{
    Database? myDb = await db;
    return  myDb!.delete('courses', where: 'id = ?', whereArgs: [id]);
  }


  Future<int> courseUpdate(Course course) async{
    Database? myDb = await db;
    return await  myDb!.update('courses', course.toMap(),where: 'id = ?', whereArgs: [course.id]);
  }


}