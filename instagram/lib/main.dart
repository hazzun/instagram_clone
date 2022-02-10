import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  var tab = 0;
  var jsonData = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if(result.statusCode == 200) {  //서버를 통한 get 요청이 예외처리(서버다운, 요청경로이상 등)일 경우
      print('succes for data coming');
    } else {
      print('fail to data');
    }
    var resultDecode = jsonDecode(result.body);
    // print(resultDecode);

    setState(() {
      jsonData = resultDecode;
      print(jsonData[0]);
    });
  }

  @override
  void initState() {  //MyApp위젯이 로드될 때 실행
    super.initState();
    getData();
  }

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
          child: [home(json : jsonData), reels()][tab]
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        }, //i 는 누른 번호가 됨
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '피드'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_outlined  ), label: '릴스'),
        ],
      ),
    );
  }
}

class home extends StatelessWidget {
  home({Key? key, this.json}) : super(key: key);
  var json;

  @override
  Widget build(BuildContext context) {
    // var image1 = json[0]['image'];
    if( json.length != null ) {
      return ListView.builder(itemCount: json.length, itemBuilder: (context, i){
        return  Container(
          width: 600,
          height: 620,
          // color: Colors.grey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.network('https://codingapple1.github.io/app/img0.jpg', height: 200,),
                        // Image.asset('young.jpeg', height: 600)
                        Image.network(json[i]['image'], height: 500,)
                      ]
                  )
              ),
              Row(
                children: [
                  Icon(Icons.favorite_border),
                  Icon(Icons.messenger_outline),
                  Icon(Icons.add_to_home_screen_outlined),
                ],
              ),
              // Text('좋아요 100,000,000,000개', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('좋아요 ' + json[i]['likes'].toString() +'개', style: TextStyle(fontWeight: FontWeight.bold)),
              // Text('볼링을 치지 널 칠순 없잖아?'),
              Text(json[i]['content']),
              Text('#볼링장에서 #찰칵 #나이쁘지', style: TextStyle(fontSize: 10),),
              // Container(
              //     padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
              //     child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Image.asset('zzun.jpeg', height: 400)
              //         ]
              //     )
              // ),
              // Row(
              //   children: [
              //     Icon(Icons.favorite_border),
              //     Icon(Icons.messenger_outline),
              //     Icon(Icons.add_to_home_screen_outlined),
              //   ],
              // ),
              // Text('좋아요 29개', style: TextStyle(fontWeight: FontWeight.bold)),
              // Text('가영이가 찍어줌')
            ],
          ),
        );
      });
    } else {
      return CircularProgressIndicator();
    }
  }
}

class reels extends StatelessWidget {
  const reels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('릴스 페이지 만드는중임', style: TextStyle(fontSize: 30),)],
      ),
    );
  }
}
