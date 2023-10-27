import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

import '../main-view/MainPage.dart';

class LoginView extends StatelessWidget{

  const LoginView({super.key});

  @override
  initState() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    print(res.account);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: const Text('DayPle', style: TextStyle(
      //       color: Colors.lightBlue,
      //       fontSize: 25),),
      // ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 100, bottom: 100),
                child:Text("DAYPLE", style: TextStyle(color: Colors.lightBlue, fontSize: 50, fontWeight: FontWeight.bold),),),
              Container(
                padding: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return MainPage(title: 'DayPle',);
                    //     },
                    //   ),
                    // );
                    NaverLoginResult res = await FlutterNaverLogin.logIn();
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('로그인 성공 : ${res.toString()}')));
                    print( res.toString() );
                    if ( res.status == NaverLoginStatus.loggedIn ) {
                      if ( kDebugMode ) {
                        SnackBar(
                          content : Text('로그인 성공 : ${res.toString()}')
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('로그인 성공 : ${res.account}')));
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MainPage(title: 'DAYPLE', username: res.account.name);
                          },
                        ),
                      );
                    }

                  },
                  child: Image.asset('assets/naver/naver_login.png', fit:BoxFit.fill, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.1),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(0.0),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.1),
                  ),
                  // child: Text('hello'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child : ElevatedButton(
                  onPressed: () {},
                  child: Image.asset('assets/kakao/kakao_login.png', fit: BoxFit.fill, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.1),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(0.0),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.1),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child : ElevatedButton(
                  onPressed: () {},
                  child: Image.asset('assets/google/google_login.png', fit: BoxFit.fill, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.1),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(0.0),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.1),
                  ),
                ),
              )

            ],
        )
      )
    );
  }
}