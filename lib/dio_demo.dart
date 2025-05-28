import 'package:flutter/material.dart';
import 'package:samsung_http_proj/user.dart';
import 'package:dio/dio.dart';

class DioDemo extends StatefulWidget {
  const DioDemo({super.key});

  @override
  State<DioDemo> createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  late Future<List<User>> usersFuture;

 Dio dio = Dio();

  @override
  void initState() {
    super.initState();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler){
        debugPrint('Request : ${request.method} and  -- Url : ${request.uri}');
        return handler.next(request);
      },
      onResponse:  (response, handler){
        debugPrint('Response : ${response.statusCode }');
        return handler.next(response);
      },
      onError:  (error, handler){
        debugPrint('Error: ${error.message}');
        return handler.next(error);
      },

    ));

    usersFuture = getRequest();
  }

  Future<List<User>> getRequest() async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      var responseData = response.data;

      List<User> users = [];
      for (var singleUser in responseData) {
        User user = User(
            id: singleUser["id"],
            userId: singleUser["userId"],
            title: singleUser["title"],
            body: singleUser["body"]);

        users.add(user);
      }

      debugPrint("User List:");
      users.forEach((user) {
        debugPrint("User ID: ${user.id}, Title: ${user.title}, Body: ${user.body}");
      });
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blueGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.0),
            // Display Fetched Users
            Expanded(
              child: FutureBuilder<List<User>>(
                future: usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No users found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data![index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            title: Text(user.title),
                            subtitle: Text(user.body),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

