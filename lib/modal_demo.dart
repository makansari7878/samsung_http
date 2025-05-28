import 'package:flutter/material.dart';
import 'package:samsung_http_proj/Dio_Demo.dart';

class ModalDemo extends StatefulWidget {
  const ModalDemo({super.key});

  @override
  State<ModalDemo> createState() => _ModalDemoState();
}

class _ModalDemoState extends State<ModalDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modal Demo'),),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40,),
            ElevatedButton(onPressed: () {
              _showModalBottomSheet(context);
            },
                child: Text('CLICK ME')),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(16),
          color: Colors.greenAccent,
          child: Column(
            children: [
              Text("Choose an option", style: TextStyle(fontSize: 18)),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DioDemo() )),
              ),
              ListTile(
                leading: Icon(Icons.save),
                title: Text("Save"),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

}
