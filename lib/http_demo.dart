import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samsung_http_proj/user.dart';




class HttpDemo extends StatefulWidget {
  const HttpDemo({super.key});


  @override
  State<HttpDemo> createState() => PaginationDemoState();
}


class PaginationDemoState extends State<HttpDemo> {
  List<User> users = [];
  int page = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    getRequest();
    _scrollController.addListener(_scrollListener);
  }


  void _scrollListener() {


/*    if (_scrollController.position.pixels >
       _scrollController.position.maxScrollExtent - 100)*/
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent ) {
      getRequest();
    }
  }


  Future<void> getRequest() async {
    if (isLoading) return;
    setState(() => isLoading = true);


    final url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url));
    final responseData = jsonDecode(response.body);


    setState(() {
      for (var singleUser in responseData) {
        users.add(User(
          id: singleUser["id"],
          userId: singleUser["userId"],
          title: singleUser["title"],
          body: singleUser["body"],
        ));
      }
      page++;
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagination Demo")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: users.length + 1,
        itemBuilder: (context, index) {
          if (index < users.length) {
            return ListTile(
              title: Text(users[index].title),
              subtitle: Text(users[index].body),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
