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
  int screenIndex = 0;


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'shopping'),
        ],
      ),
      // BottomAppBar(
      //   child: Container(
      //     height: 50,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         IconButton(onPressed: (){}, icon: Icon(Icons.home_outlined)),
      //         IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag_outlined)),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
