import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/data/entitys/base_model_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/routers/fluro_navigator.dart' as prefix1;
import 'package:wanandroid/routers/routers.dart';
import 'package:wanandroid/utils/prefer_constants.dart';
import 'package:wanandroid/pages/login/index_login.dart';

//抽屉式布局页面
class HomeDrawerPage extends StatefulWidget {
  @override
  _HomeDrawerPageState createState() => _HomeDrawerPageState();
}

class _HomeDrawerPageState extends State<HomeDrawerPage> {
  String userName = '';

  void _showDioalog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Text('账号已登录,是否注销？'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  '取消',
                  style: TextStyle(color: Colors.red[200]),
                ),
                onPressed: () {
                  NavigatorUtils.goBack(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('确定', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  NavigatorUtils.goBack(context);
                  //注销操作，并跳转到登录页
                  _loginOut();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryData.fromWindow(window).size.width * 0.8,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            accountName: Text(
              userName,
              style: TextStyle(color: Colors.yellowAccent),
            ),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            otherAccountsPictures: <Widget>[
              userName.length == 0
                  ? Container(
                      padding: EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: Text(
                          '登录',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  : null
            ],
          ),
          ListTile(
            title: Text('我的收藏'),
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text('主题色选择'),
            leading: Icon(Icons.color_lens, color: Colors.yellow),
          ),
          userName.length != 0
              ? InkWell(
                  onTap: () {
                    _showDioalog(context);
                  },
                  child: ListTile(
                    title: Text('注销'),
                    leading: Icon(Icons.power_settings_new),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    userName = sp.getString(PrefsProvider.USER_NAME) ?? '';
    setState(() {});
  }

  _loginOut() async {
    await DioHelper().get(RequestUrl.loginOut, null, (successInfo) {
      BaseModelEntity info = BaseModelEntity().fromJson(successInfo);
      setState(() {
        PrefsProvider.clearLoginInfo();
      });
      NavigatorUtils.push(context, Routes.loginPage);
    }, (errorCallBack) {
      ToastHelper.showWarning(errorCallBack.toString());
    });
  }
}
