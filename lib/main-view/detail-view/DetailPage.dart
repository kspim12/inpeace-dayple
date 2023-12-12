import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage {
  void showDetailPage(BuildContext context, String item) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 0.5,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color : Colors.blue[100],
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    if ( index == 0 ) {
                      return Icon(
                        Icons.keyboard_arrow_down,
                        size: 50,
                      );
                    }

                    if ( index == 1 ) {
                      return Container(
                        margin: const EdgeInsets.all(50.0),
                        child: Image.network(item,fit: BoxFit.fill,width: MediaQuery.of(context).size.width * 0.7,),
                      );
                    }

                    if ( index == 2 ) {
                      return Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child:Text('주소', style: TextStyle(fontWeight: FontWeight.w900)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child:Text('경기도 하남시 망월동 1191'),
                          ),
                          Container(width: MediaQuery.of(context).size.width,child: Divider(color: Colors.grey, thickness: 1.0, )),
                        ],
                      ));
                    }

                    if ( index == 3 ) {
                      return Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child:Text('영업 시간', style: TextStyle(fontWeight: FontWeight.w900)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child:Text('11:00 ~ 22:00'),
                              ),
                              Container(width: MediaQuery.of(context).size.width,child: Divider(color: Colors.grey, thickness: 1.0, )),
                            ],
                          ));
                    }

                    if ( index == 4 ) {
                      return Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child:Text('전화번호', style: TextStyle(fontWeight: FontWeight.w900)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child:Text('011 0000 0000'),
                              ),
                              Container(width: MediaQuery.of(context).size.width,child: Divider(color: Colors.grey, thickness: 1.0, )),
                            ],
                          ));
                    }

                    if ( index == 5 ) {
                      return Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child:Text('리뷰 24', style: TextStyle(fontWeight: FontWeight.w900)),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child:Text('글쓰기', style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),

                              Stack(

                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('최신순')
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('ㅁ 사진만 보기')
                                  )
                                ],
                              ),

                              Container(
                                
                              ),

                              Container(width: MediaQuery.of(context).size.width,child: Divider(color: Colors.grey, thickness: 1.0, )),
                            ],
                          ));
                    }
                  }
                )
              );
            },
          ),
        );
      },
      elevation: 50,
      enableDrag: true,
      isDismissible: true,
      barrierColor: Colors.grey.withOpacity(0.3),
      backgroundColor: Colors.amber,
      constraints: BoxConstraints(
        minWidth: 100,
        // maxWidth: MediaQuery.of(context).size.width,
        minHeight: 100,
        maxHeight: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            10,
      ),
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(30),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        side: const BorderSide(color: Colors.purple, width: 5),
      ),
      isScrollControlled: true,
      useSafeArea: true,
    );
  }
}
