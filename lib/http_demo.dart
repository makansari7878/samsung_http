import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samsung_http_proj/user.dart';

class HttpDemo extends StatefulWidget {
  HttpDemo({super.key});

  @override
  State<HttpDemo> createState() => PaginationDemoState();
}

class PaginationDemoState extends State<HttpDemo> {
  List<User> users = [];
  int page = 1;
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getRequest();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 50 &&
        !isLoading) {
      getRequest();
    }
  }

  Future<void> getRequest() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final url = "https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        setState(() {
          users.addAll(responseData.map((singleUser) => User(
            id: singleUser["id"],
            userId: singleUser["userId"],
            title: singleUser["title"],
            body: singleUser["body"],
          )));
          page++;
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagination Demo")),
      body: ListView.builder(
        controller: scrollController,
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