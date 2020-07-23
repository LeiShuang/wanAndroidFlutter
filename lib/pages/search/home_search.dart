import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/data/entitys/hot_key_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/routers/routers.dart';
import 'package:wanandroid/utils/theme_utils.dart';
import 'package:wanandroid/widgets/common_loading.dart';

class HomeSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeSearchState();
  }
}

class _HomeSearchState extends State<HomeSearch> {
  final searchController = TextEditingController(text: '');
  List<HotKeyEntityData> hotList = List();
  List<Widget> widgetList = List();
  List<Widget> commonList = List();

  @override
  void initState() {
    super.initState();
    commonList.add(CommonLoading());
    _initData();
  }

  void _initData() async {
    await DioHelper().get(RequestUrl.hotSearch, null, (successCallBack) {
      if (successCallBack != null) {
        HotKeyEntity info = HotKeyEntity().fromJson(successCallBack);
        if (info.errorCode == 0) {
          setState(() {
            hotList.clear();
            hotList.addAll(info.data);
            for (int i = 0; i < hotList.length; i++) {
              widgetList.add(Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                    top: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20)),
                child: FlatButton(
                    color: ThemeUtils.currentColorTheme,
                    highlightColor: ThemeUtils.currentColorTheme,
                    splashColor: ThemeUtils.currentColorTheme,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(20))),
                    onPressed: () {
                      NavigatorUtils.push(context,
                          '${Routes.searchResult}?title=${Uri.encodeComponent(hotList[i].name)}',replace: true);
                    },
                    child: Text(hotList[i].name)),
              ));
            }
          });
        } else {
          ToastHelper.showWarning(info.errorMsg);
        }
      }
    }, (errorCallBack) {
      ToastHelper.showWarning(errorCallBack.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
              height: ScreenUtil().setWidth(100),
              alignment: Alignment.center,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    hintText: "请输入搜索内容:",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(35),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(4.0))),
                    contentPadding: const EdgeInsets.all(4.0)),
              ),
            )),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                width: ScreenUtil().setWidth(100),
                height: ScreenUtil().setWidth(100),
                child: Text(
                  '搜索',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(48), color: Colors.white),
                ),
              ),
              onTap: () {
                if (searchController.text.trim().isEmpty) {
                  ToastHelper.showWarning("搜索关键词不能为空!");
                  return;
                }
                NavigatorUtils.push(context,
                    '${Routes.searchResult}?title=${Uri.encodeComponent(searchController.text.trim().toString())}',replace: true);
              },
            )
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: Container(
        margin: EdgeInsets.all(ScreenUtil().setWidth(25)),
        child: Wrap(
          children: hotList.length > 0 ? widgetList : commonList,
        ),
      ),
    );
  }
}
