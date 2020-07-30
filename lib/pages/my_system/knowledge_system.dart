import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wanandroid/data/entitys/system_data_entity.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/pages/my_system/system_router.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/widgets/loading_state.dart';

import 'net.dart';

import 'package:wanandroid/widgets/common_loading.dart';


class SystemsPage extends StatefulWidget {
  @override
  _SystemsPageState createState() => _SystemsPageState();
}

class _SystemsPageState extends State<SystemsPage> with AutomaticKeepAliveClientMixin<SystemsPage>, SingleTickerProviderStateMixin{

  @override
  bool get wantKeepAlive => true;
  LoadState _loadState = LoadState.State_Loading;
  List<SystemDataData> entityList = new List();

  @override
  void initState() {
    super.initState();

    getSystemList().then((value) =>{
      setState((){
        if(value.errorCode == 0){
         if(value.data.length == 0){
           _loadState = LoadState.State_Empty;
         }else{
           _loadState = LoadState.State_Success;
         }
         entityList.addAll(value.data);
        }else{
          _loadState = LoadState.State_Error;
        }
      })

    }

    );

  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
      Scaffold(
        appBar: AppBar(
          title: Text("体系"),
          centerTitle: true,
        ),
        body: LoadStateLayout(loadState: _loadState, errRetry: (){
            setState(() {
              _loadState = LoadState.State_Error;
            });
        }, emptyRetry: (){
            setState(() {
              _loadState = LoadState.State_Empty;
            });
        }, successWidget: Container(
        child: ListView.builder(
        itemCount: entityList.length,
            itemBuilder:(context,index){
              return _buildItems(index);
            }
        ),
      ))
      );/*entityList.length > 0 ? Scaffold(
      appBar: AppBar(
        title: Text("体系"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: entityList.length,
          itemBuilder:(context,index){
            return _buildItems(index);
          }
        ),
      ),
    ) : CommonLoading();*/
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
            ToastHelper.showToast("点击了"+child.name);
            NavigatorUtils.push(context, '${SystemRouter.systemList}?knowledgeId=${child.id}&title=${Uri.encodeComponent(child.name)}');
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

