import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_provider/screens/updatecourse.dart';
import '../provider/my_provider.dart';
import '../model/course.dart';
import 'coursedetails.dart';
import 'newcourse.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  Icon _searchIcon =   const Icon(Icons.search);
  Widget _appBarTitle = const Text('SQLite Database');
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";


  HomeState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
        Provider.of<MyProvider>(context, listen: false).filteredCourse =  Provider.of<MyProvider>(context, listen: false).allCourses;
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text('SQLite Database');
        // filteredNames = names;
        _filter.clear();
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero, () async {
      Provider.of<MyProvider>(context, listen: false).getCourses();
    });

    if (_searchText.isNotEmpty) {
      List tempList = [];
      for (int i = 0; i <  Provider.of<MyProvider>(context, listen: false).filteredCourse.length; i++) {
        if ( Provider.of<MyProvider>(context, listen: false).filteredCourse[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add( Provider.of<MyProvider>(context, listen: false).filteredCourse[i]);
        }
      }
      Provider.of<MyProvider>(context, listen: false).filteredCourse = tempList;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const NewCourse()));
              setState(() {
                Provider.of<MyProvider>(context, listen: false).getCourses();
              });
              },
          )
        ],
        leading: IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,

        ),
      ),
      body:  Provider.of<MyProvider>(context, listen: true).filteredCourse.isEmpty?const Center(child: Text("no data")):
      ListView.builder(
          itemCount:   Provider.of<MyProvider>(context, listen: true).filteredCourse.length,
          itemBuilder: (context, i){
            Provider.of<MyProvider>(context, listen: true).setCourse(Course(Provider.of<MyProvider>(context, listen: true).filteredCourse[i]));
            return Card(
              color: Colors.white70,
              child: ListTile(
                title: Text('${Provider.of<MyProvider>(context, listen: true).course.name} - ${Provider.of<MyProvider>(context, listen: true).course.price} EGP'),
                subtitle: Text(Provider.of<MyProvider>(context, listen: true).course.content!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    IconButton(icon: const Icon(Icons.delete, color: Colors.red,)
                      ,onPressed: () async{
                      Provider.of<MyProvider>(context, listen: false).deleteCourse(Provider.of<MyProvider>(context, listen: false).course.id!).then((response) {
                         debugPrint("data deleted ================== $response");
                        Provider.of<MyProvider>(context, listen: false).getCourses();
                      });

                      },),
                    IconButton(icon: const Icon(Icons.edit, color: Colors.green,)
                      ,onPressed: () async{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const UpdateCourse()))
                          .then((_){
                        Provider.of<MyProvider>(context, listen: false).getCourses();

                         });

                         },
                    ),
                  ],
                ),
                onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CourseDetails()));
                },
              ),
            );
          }
      ),
    );
  }

}

