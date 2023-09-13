import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userList=[];
  Future<List<UserModel>> getUser() async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users"),),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUser(),
              builder: (context,snapshot){
              if(!snapshot.hasData){
                return const Text("Loading...");
              }else{
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              CardLayout(title: "Name", value: snapshot.data![index].name.toString()),
                              CardLayout(title: "Username", value: snapshot.data![index].username.toString()),
                              CardLayout(title: "Email", value: snapshot.data![index].email.toString()),
                              CardLayout(title: "Phone", value: snapshot.data![index].phone.toString()),
                              CardLayout(title: "Address", value: "${snapshot.data![index].address!.geo!.lng} / ${snapshot.data![index].address!.geo!.lat}"),
                            ],
                          ),
                        ),
                      );
                    });
              }

              }))

        ],
      ),
    );
  }
}
class CardLayout extends StatelessWidget {
  String title,value;
  CardLayout({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value)
      ],

    );
  }
}

