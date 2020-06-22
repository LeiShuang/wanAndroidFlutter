import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wanandroid/data/entitys/web_guide_entity.dart';
import 'package:wanandroid/pages/my_system/net.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';

//void main() => runApp(WebGuideApp());
//
//class WebGuideApp extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: "网站导航",
//      theme: ThemeData(primarySwatch: Colors.blue),
//      home: WebGuidePage(),
//    );
//  }
//}


class WebGuidePage extends StatefulWidget {
  @override
  _WebGuidePageState createState() => _WebGuidePageState();
}

class _WebGuidePageState extends State<WebGuidePage> with AutomaticKeepAliveClientMixin<WebGuidePage>, SingleTickerProviderStateMixin{

  @override
  bool get wantKeepAlive => true;

  List<WebGuideData>  _entityList = new List();
  List<WebGuideDataArticle> _articles = new List();
  var _leftIndex = 0;


  @override
  void initState() {
    super.initState();
    getWebGuideList().then((value) => {
      setState(() {
        _entityList.addAll(value.data);
        _articles.addAll(_entityList[_leftIndex].articles);
      })
    });

  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
//      appBar: AppBar(
//        title: Text("网站导航"),
//        centerTitle: true,
//      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: _entityList.length,
                itemBuilder: (context,index){
                  return _buildListItems(index);
                }),
          ),
          Expanded(
              flex: 2,
              child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,////横轴两个子widget
                  childAspectRatio: 1.0////子widget 宽高比为1
                ),
                itemCount: _articles.length,
                itemBuilder: (context,index){
                  return _buildGridItems(index);
              })
          )

        ],
      ),
    );
  }

  _buildListItems(int index) {

    return GestureDetector(
      onTap: (){
        setState(() {
          _leftIndex = index;
          _articles = _entityList[_leftIndex].articles;
        });

      },
      child:Container(
        height: 48,
        color: _leftIndex == index ? Colors.white : Color(0xFFE0E0E0),
        child: Center(
          child: Text(_entityList[index].name,style: TextStyle(fontSize: 16),),
        ),
      ) ,
    );

  }

  _buildGridItems(int index){
    List<Color> colors = _randomColor();//构建随机色
    return Container(
      margin: const EdgeInsets.all(4),
      color: colors[0],
      child: GestureDetector(
        onTap: (){
          WebGuideDataArticle article = _entityList[_leftIndex].articles[index];
          String linkUrl = article.link;
          String title = article.title;
          NavigatorUtils.goWebViewPage(context, title, linkUrl);
        },
        child: Center(
          child: Text(_articles[index].title,style: TextStyle(fontSize: 16,color: colors[1]),textAlign: TextAlign.center,),
      ),
      ),
    );
  }

  List<Color> _randomColor() {
    int R = Random().nextInt(256)+0;
    int G = Random().nextInt(256)+0;
    int B = Random().nextInt(256)+0;
    Color bgColor = Color.fromARGB(255,R ,G,B );
    Color txColor = Color.fromARGB(255, 256-R, 256-G, 256-B);
    List<Color> colors = new List();
    colors.add(bgColor);
    colors.add(txColor);
    return colors;
  }
}
