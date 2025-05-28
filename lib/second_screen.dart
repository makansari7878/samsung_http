
import 'package:flutter/material.dart';
import 'package:samsung_http_proj/user_provider.dart';


class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final userProvider = UserProvider.of(context);
    final userId = userProvider?.userId;


    return Scaffold(
      appBar: AppBar(title: const Text('SECOND SCREEN')),
      body: Container(
        color: Colors.yellowAccent,
        padding: const EdgeInsets.only(left: 10, top: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
          children: [
            Text(
              'USER ID: $userId', // Removed extra curly brace
              style: const TextStyle(fontSize: 20,color: Color(0xFFB11D87),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {},child: const Text('Click me'),
            ),
          ],
        ),
      ),
    );
  }
}

