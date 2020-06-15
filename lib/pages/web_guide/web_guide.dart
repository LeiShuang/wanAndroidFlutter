
import 'package:flutter/material.dart';
import 'package:wanandroid/pages/my_system/net.dart';
import 'package:wanandroid/pages/web_guide/web_guide_entity.dart';

void main() => runApp(WebGuideApp());

class WebGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "网站导航",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WebGuidePage(),
    );
  }
}


class WebGuidePage extends StatefulWidget {
  @override
  _WebGuidePageState createState() => _WebGuidePageState();
}

class _WebGuidePageState extends State<WebGuidePage> {

  List<WebGuideData>  entityList = new List();

  @override
  void initState() {
    super.initState();
    getWebGuideList().then((value) => entityList.addAll(value.data));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("网站导航"),
        centerTitle: true,
      ),
      body: Row(

        children: [
          Container(
            child: ListView.builder(
                itemCount: entityList.length,
                itemBuilder: (context,index){
                  return _buildItems(index);
                }),
          ),

//          GridView.builder(
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 2,////横轴两个子widget
//                childAspectRatio: 1.0////子widget 宽高比为1
//              ),
//              itemBuilder: null)
        ],
      ),
    );
  }

  _buildItems(int index) {
    return Container(
      child: Text(entityList[index].name),
    );
  }
}
