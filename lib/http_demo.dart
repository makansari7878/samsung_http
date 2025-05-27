import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samsung_http_proj/user.dart';
import 'package:samsung_http_proj/user_details.dart';

class HttpDemo extends StatefulWidget {
  const HttpDemo({super.key});

  @override
  State<HttpDemo> createState() => _HttpDemoState();
}

class _HttpDemoState extends State<HttpDemo> {

  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  Future<List<User>>  fetchUsers() async{
    String url = 'https://jsonplaceholder.typicode.com/posts';
    var response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    debugPrint(responseData.toString());

    List<User> usersList = [];
    for(var eachUser in responseData){
      User user = User(
          id: eachUser['id'],
          userId: eachUser['userId'],
          title: eachUser['title'],
          body: eachUser['body']);
      usersList.add(user);
    }

    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HTTP dEMO'),),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 10),
        color: Colors.limeAccent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: fetchUsers(),
                    builder: (ctx, snapshot){
                      if(snapshot == null){
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      else{
                        return ListView.builder(

                          itemCount: snapshot.data?.length,
                            itemBuilder: (ctx, index) => Card(
                          margin: EdgeInsets.all(10),
                          color: Colors.greenAccent,
                          elevation: 10,
                          child: ListTile(
                            title: Text(snapshot.data![index].title, style:TextStyle(fontSize: 20, color: Colors.redAccent),),
                            subtitle: Text(snapshot.data![index].body, style:TextStyle(fontSize: 20, color: Colors.black)),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder:(context) {
                                return UserDetails(user : snapshot.data![index]);
                              }));
                            },
                          ),



                          ),
                        );
                      }
                    }

                ))
          ],
        ),
      ),
    );
  }
}
