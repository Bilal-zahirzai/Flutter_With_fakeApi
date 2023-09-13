import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Photos> photosList=[];
  Future<List<Photos>> getPhotos()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        Photos photos=Photos(title: i['title'], url: i['url'],id:i['id']);
        photosList.add(photos);
      }
      return photosList;
    }else{
      return photosList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Photos Api"),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
                builder: (context,snapshot){
              return ListView.builder(
                itemCount: photosList.length,
                  itemBuilder:(context,index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:NetworkImage(photosList[index].url.toString()),
                    ),
                    title: Text("user ID : "+photosList[index].id.toString()),
                    subtitle: Text(photosList[index].title),
                  );

                  });
            }),
          )
        ],
      ),
    );
  }
}
class Photos{
  String title,url;
  int id;
  Photos({required this.title,required this.url,required this.id});
}
