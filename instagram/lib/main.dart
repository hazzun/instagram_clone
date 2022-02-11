import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';  //스크롤 관련 유용한 함수들이 들어있음

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
      // print(jsonData[0]);
    });
  }

  addMoreData(a){
    setState(() {
      jsonData.add(a);
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
        actions: [
          IconButton(icon: Icon(Icons.add_box_outlined),
            onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => Upload())
            );
            },)
        ],
      ),
      body: Container(
          child: [home(json : jsonData, addMoreData: addMoreData), reels()][tab]
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

class home extends StatefulWidget {  //scrollbar 위치 측정하려면 ListView 담은곳이 StatefullWidget이어야 함
  home({Key? key, this.json, this.addMoreData}) : super(key: key);
  var json;
  var addMoreData;

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  var scroll = ScrollController();
  var jsonDataMore = [];

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {   //왼쪽의변수(scroll)이 변할 때 마다 안의 코드를 실행시켜
     // print(scroll.position.pixels);
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        getJsonData();
      } else {}
    });
  }
  getJsonData() async {
    var jsonData = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var jsonData2 = await http.get(Uri.parse('https://codingapple1.github.io/app/more2.json'));
    var jsonDataDecode = jsonDecode(jsonData.body);
    var jsonDataDecode2 = jsonDecode(jsonData2.body);
    print(jsonDataDecode);
    print(jsonDataDecode2);
    widget.addMoreData(jsonDataDecode);
    widget.addMoreData(jsonDataDecode2);
  }

  @override
  Widget build(BuildContext context) {
    // var image1 = json[0]['image'];
    if( widget.json.length != null ) {  //StatefullWidget은 부모가 보낸 state등록은 첫번째 class, 사용은 두번째 class에서 해야 함
      return ListView.builder(
          itemCount: widget.json.length ,
          controller: scroll,
          itemBuilder: (context, i){
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
                        Image.network(widget.json[i]['image'], height: 500,)
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
              Text('좋아요 ${widget.json[i]['likes']}개', style: TextStyle(fontWeight: FontWeight.bold)),
              // Text('볼링을 치지 널 칠순 없잖아?'),
              Text(widget.json[i]['content']),
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

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이미지업로드화면'),
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //   MaterialPageRoute(builder: (c)=> Text('test'))
                  // );
                },
                icon: Icon(Icons.close)
            ),
          ],
        )
    );

  }
}