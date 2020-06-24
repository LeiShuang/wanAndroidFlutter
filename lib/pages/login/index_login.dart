import 'package:flutter/material.dart';
import 'package:wanandroid/utils/images_provider.dart';
import 'package:wanandroid/utils/theme_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('登录'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50, bottom: 20),
            child: Image.asset(
              ImagesProvider.getImagePath('logo'),
              width: 120,
              height: 120,
            ),
          ),
          TextField(
            decoration: InputDecoration(

                icon: Icon(Icons.person),
                hintText: '请输入账号',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                helperText: '请输入账号',
                border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: ThemeUtils.defaultColor,
                    ))),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline),
                hintText: '请输入密码',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                helperText: '请输入密码',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: ThemeUtils.defaultColor,
                    ))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 30),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      '登录',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightBlue,
                    highlightColor: Colors.blue,
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
