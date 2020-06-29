import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/routers/routers.dart';
import 'package:wanandroid/utils/images_provider.dart';
import 'package:wanandroid/utils/theme_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPhoneClose = false;
  bool showPasswordClose = false;
  String phone;
  String password;
  TextEditingController _onPhoneController = TextEditingController();
  TextEditingController _onPasswordController = TextEditingController();
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('登录'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50, bottom: 10),
            child: Image.asset(
              ImagesProvider.getImagePath('logo'),
              width: 100,
              height: 100,
            ),
          ),
          createInputBox(_onUserNameChange, _onPhoneController,
              Icons.phone_android, showPhoneClose, false),
          createInputBox(_onPassWordChange, _onPasswordController,
              Icons.lock_outline, showPasswordClose, true),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      _login;
                    },
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('没有账号?'),
              InkWell(
                  onTap: () {
                    NavigatorUtils.goBack(context);
                    NavigatorUtils.push(context, Routes.loginPage);
                  },
                  child: Text(
                    '去注册',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  void initPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _onUserNameChange(String username) {
    phone = username;
    if (phone.length > 0) {
      setState(() {
        showPhoneClose = true;
      });
    } else {
      setState(() {
        showPhoneClose = false;
      });
    }
  }

  void _onPassWordChange(String passWord) {
    password = passWord;
    if (password.length > 0) {
      setState(() {
        showPasswordClose = true;
      });
    } else {
      setState(() {
        showPasswordClose = false;
      });
    }
  }

  createInputBox(
      ValueChanged<String> onStringChange,
      TextEditingController controller,
      IconData icon,
      bool showCloseIcon,
      bool isPassWord) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextField(
            obscureText: isPassWord ? true : false,
            style: TextStyle(fontSize: 16.0),
            maxLines: 1,
            onChanged: onStringChange,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 5, 50, 5),
              border: InputBorder.none,
              icon: Icon(
                icon,
                color: ThemeUtils.defaultColor,
              ),
              hintText: isPassWord ? "请输入密码" : "请输入用户名",
            ),
          ),
          showCloseIcon
              ? Container(
                  margin: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      controller.clear();
                      setState(() {
                        isPassWord
                            ? showPasswordClose = false
                            : showPhoneClose = false;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
  _login(){
    DioHelper().post(RequestUrl.login,{'username':phone,'password':password}, (logindata){
      ToastHelper.showToast("登录成功");

    }, (errMsg){
      ToastHelper.showToast(errMsg);
    });
  }
}
