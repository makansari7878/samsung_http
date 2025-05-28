import 'package:flutter/material.dart';
import 'package:samsung_http_proj/second_screen.dart';
import 'package:samsung_http_proj/user_provider.dart';


class InheritedWidgetDemo extends StatefulWidget {
  const InheritedWidgetDemo({super.key});

  @override
  State<InheritedWidgetDemo> createState() => _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  String _currentUserId = 'user_initial id : 123';

  void _changeUserId() {
    setState(() {
      _currentUserId = 'user_changed : ${DateTime.now().millisecond}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedWidget Example'),
      ),
      body: UserProvider(
        userId: _currentUserId,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Top-Level Widget',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // SecondScreen will take remaining space
              const Expanded(
                child: SecondScreen(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _changeUserId,
                child: const Text('Change User ID'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
