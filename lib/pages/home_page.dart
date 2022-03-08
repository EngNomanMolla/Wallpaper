import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/model_class/model.dart';
import 'package:wallpaper/pages/set_wallpaper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 int ?currentPage;
  final Uri uri  =Uri.parse("https://picsum.photos/v2/list?page="+currentPage.toString()+"&limit=10") ;
  //final Uri uri  =Uri.parse("https://picsum.photos/v2/list");
  List<ModalClass> list1 = [];

  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }

  getDataFromApi() async {
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var list = jsonDecode(response.body);
        for (var i in list) {
          list1.add(ModalClass.fromJson(i));

        }
        setState(() {

        });
        print(list1[1].author);

      } else {
        throw Exception("Network Error");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        title: Text("Wallpaper",style: TextStyle(letterSpacing: 2.0)),
        centerTitle: true,
      ),
      body:Container(
    child: ListView.builder(

    itemCount: list1.length,
    itemBuilder: (BuildContext context,index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0)
            ),
            child: CachedNetworkImage(
            imageUrl: list1[index].downloadUrl!,
              height: 250,
             // width:150,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(child: CupertinoActivityIndicator()),
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SetWallpaper(list1[index].downloadUrl)));



          },
        ),

      );
    }),
    ));
  }
}
