import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dayple/main-view/detail-view/DetailPage.dart';
import 'package:dayple/main-view/map-view/MyMap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart' as http;


class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title, required this.username});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String username;

  @override
  State<MainPage> createState() => _MainPageState();
}

bool isDragging = false;
String location = "";


class _MainPageState extends State<MainPage> {
  int image_index = 0;

  String myLocation = "";

  @override
  initState() {

    getLocation();

    location = "abc";
  }

  Future<String> getLocation() async {
    final response = await http.get(Uri.parse("http://localhost:8080/ncloud/geolocation"));

    print(response.body);
    myLocation = response.body;
    return response.body;
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.add_alert_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Future<NaverLoginResult> res = FlutterNaverLogin.logOut();
                  res.then((value) => print(value));
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout))
          ],
          automaticallyImplyLeading: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text('${widget.username} 님을 위한 추천 코스'),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>  [
                Icon(Icons.location_on_outlined),
                Text('현재 위치 :: ${myLocation} '),
              ]),
          Container(
            child: Stack(alignment: Alignment.centerLeft, children: <Widget>[
              Positioned(
                left: MediaQuery.of(context).size.width / 2,
                // right: 90,
                // top: MediaQuery.of(context).size.height / 10,
                child: Container(
                  // 가운데 긴 줄
                  height: 10.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.lightBlue,
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  // scrollDirection: Axis.vertical,
                  // viewportFraction: 0.7,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  enableInfiniteScroll: false,
                ),
                items: imgList
                    .map((item) => Container(
                          margin: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Stack(
                                children: <Widget>[
                                  LongPressDraggable<int>(
                                    data: imgList.indexOf(item),
                                    onDragStarted: () => {
                                      print('drag start'),
                                      setState(() {
                                        isDragging = true;
                                      }),
                                    },
                                    onDragEnd: (detail) => {
                                      print('drag end'),
                                      setState(() {
                                        isDragging = false;
                                      }),
                                    },
                                    feedback: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(300.0),
                                          border: Border.all(
                                            width: 10,
                                            color: Colors.lightBlue,
                                          )),
                                      width: 300,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(300.0),
                                          child: Image.network(
                                            item,
                                            fit: BoxFit.fill,
                                            width: 1000.0,
                                          )),
                                    ),
                                    // **************************** 메인 그림 ****************************/
                                    // child: Image.network(item,
                                    //     fit: BoxFit.fill, width: 1000.0),
                                    child: TextButton(
                                      onPressed: () {
                                        print('pressed $item');
                                        DetailPage().showDetailPage(
                                            context, item);
                                      },
                                      child: Image.network(item,
                                          fit: BoxFit.fill, width: 1000.0),
                                    )
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 25.0),
                                      child: Text(
                                        'No. ${imgList.indexOf(item)} image',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ))
                    .toList(),
              ),
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          DragTarget<int>(
            builder: (BuildContext context, List<int?> candidateData,
                List<dynamic> rejectedData) {
              return Align(
                alignment: Alignment.bottomLeft,
                  // color: Colors.cyan,
                  child: Visibility(
                    visible: isDragging,
                    child: Center(
                      child: Icon(Icons.delete, size: 70),
                    ),
                  ));
            },
            onAccept: (int image_index) {
              showDialog(context: context, builder: (BuildContext context) => Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('코스에서 삭제 하시겠습니까?'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          print(image_index);
                          this.image_index = image_index;
                          imgList.removeAt(image_index);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('예'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('아니오'),
                    ),
                  ]
                )
              ));

            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Delete Last',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
        onTap: (int index) {
          setState(() {
            if (kDebugMode) {
              if (index == 0) {
                imgList.removeLast();
              } if ( index == 1){
                print("hello?");
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MyMap()));
              }
            }
          });
        },
      ),
    );
  }
}

final List<String> imgList = [
  'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230726_25%2F1690358658880M1GTF_JPEG%2F795D9A19-2210-427E-A337-F83D0EDD687C.jpeg',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://cdn-icons-png.flaticon.com/512/9055/9055000.png'
];
