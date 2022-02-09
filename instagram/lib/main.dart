import 'package:flutter/material.dart';
import 'style.dart' as style;

void main() {
  runApp(
      MaterialApp(
          theme: style.theme, // import 해오기
          home: MyApp()
      )
  );
}

  var a = TextStyle(fontSize: 20, );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start ,
          children: [
            Text('Instagram', style: a),
          ],
        ),
        actions: [IconButton(icon: Icon(Icons.add_box_outlined), onPressed: (){},)],
      ),
      body: Container(
          child: Icon(Icons.favorite_border)
      ),
      bottomNavigationBar: BottomAppBar(
        child: Icon(Icons.live_help),
      ),
    );
  }
}
