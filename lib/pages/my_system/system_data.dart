import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'file:///E:/wanAndroidFlutter/lib/data/entitys/system_data_entity.dart';

import 'net.dart';

//void main() => runApp(MySystemsApp());
//
//class MySystemsApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: "体系",
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: SystemsPage(),
//    );
//  }
//}

class SystemsPage extends StatefulWidget {
  @override
  _SystemsPageState createState() => _SystemsPageState();
}

class _SystemsPageState extends State<SystemsPage> with AutomaticKeepAliveClientMixin<SystemsPage>, SingleTickerProviderStateMixin{

  @override
  bool get wantKeepAlive => true;

  List<SystemDataData> entityList = new List();

  @override
  void initState() {
    super.initState();

    getSystemList().then((value) =>{
      setState((){
        entityList.addAll(value.data);
      })

    }

    );

  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
//      appBar: AppBar(
//        title: Text("体系"),
//        centerTitle: true,
//      ),
      body: Container(
        child: ListView.builder(
          itemCount: entityList.length,
          itemBuilder:(context,index){
            return _buildItems(index);
          }
        ),
      ),
    );
  }

  /*
  * listview的item
  * 分为标题栏和具体流式布局
  * */
  _buildItems(int index){
    return Container(
      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            entityList.length > 0 ? entityList[index].name : "",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Wrap(
            spacing: 8.0,//主轴(水平)方向间距
            runSpacing: 0,//纵轴（垂直）方向间距
            alignment: WrapAlignment.start,//从左开始排布
            children: _buildChildLabel(index),
          )
        ],
      ),
    );
  }

  /*
  * 构建流式布局
  * */
  _buildChildLabel(int index){
    if(entityList.length > 0){
      List<SystemDataDatachild> children = entityList[index].children;
      List<Widget> chips = new List();
      
      for(int i = 0;i < children.length;i++){
        SystemDataDatachild child = children[i];
        List<Color> colors = _randomColor();//构建随机色
        Widget widget = GestureDetector(
          child: Chip(label: Text(child.name,style: TextStyle(color: colors[1]),),backgroundColor: colors[0],),
          onTap: (){
            ToastHelper.showToast("点击");
//            NavigatorUtils.goWebViewPage(context, title, url)
          },
        );
        
        chips.add(widget);
      }
     
      return chips;
    }else{
      return null;
    }
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

