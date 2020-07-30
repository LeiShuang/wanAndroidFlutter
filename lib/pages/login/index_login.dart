import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/data/entitys/login_info_entity_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/routers/fluro_navigator.dart' as prefix0;
import 'package:wanandroid/routers/routers.dart';
import 'package:wanandroid/utils/images_provider.dart';
import 'package:wanandroid/utils/prefer_constants.dart';
import 'package:wanandroid/utils/theme_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phone;
  String password;
  TextEditingController _onPhoneController = TextEditingController();
  TextEditingController _onPasswordController = TextEditingController();
  SharedPreferences prefs;
  bool isLogin = false;
  bool obpassWord = true;
  bool obUserName = false;
  @override
  void initState() {
    super.initState();
    initPreference();

  }

  @override
  Widget build(BuildContext context) {
    var loadingView;
    if (isLogin) {
      loadingView = Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[CupertinoActivityIndicator(), Text("登录中，请稍等...")],
        ),
      ));
    } else {
      loadingView = Center();
    }

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
          createInputBox(_onPhoneController, Icons.person, Icons.close, false),
          createInputBox(_onPasswordController, Icons.lock_outline,Icons.visibility,true),
          Padding(
            padding: EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      if (isLogin) {
                        return;
                      }
                      if (_onPhoneController.text.trim().toString().length ==
                              0 ||
                          _onPasswordController.text.trim().toString().length ==
                              0) {
                        ToastHelper.showWarning("账号或密码为空!");
                        return;
                      }
                      _login();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      '登录',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: ThemeUtils.currentColorTheme,
                    highlightColor: ThemeUtils.currentColorTheme,
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
                    NavigatorUtils.push(context, Routes.registerPage);
                  },
                  child: Text(
                    '去注册',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ))
            ],
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              Expanded(child: loadingView),
            ],
          ))
        ],
      ),
    );
  }

  void initPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  createInputBox(
      TextEditingController controller, IconData leftIcon,IconData rightIcon, bool isPassWord) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(5)),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          TextField(
            obscureText: isPassWord ? obpassWord :obUserName,
            style: TextStyle(
              fontSize: 16,
            ),
//                  maxLength: 10,
            maxLines: 1,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 5, 50, 5),
              border: InputBorder.none,
              icon: Icon(
                leftIcon,
                color: Colors.blue,
              ),
              labelText: !isPassWord ? '请输入用户名' : '请输入密码',
            ),
          ),
           Container(
                  margin: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      if(isPassWord){
                        setState(() {
                          obpassWord = !obpassWord;
                        });

                      }else{
                        setState(() {
                          controller.clear();
                        });

                      }
                    },
                    child: Icon(
                      rightIcon,
                      color: Colors.grey,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _login() async {
    setState(() {
      isLogin = true;
    });

    DioHelper().post(RequestUrl.login, {
      'username': _onPhoneController.text.trim().toString(),
      'password': _onPasswordController.text.trim().toString()
    }, (loginData) {
      setState(() {
        isLogin = false;
      });

      LoginInfoEntityEntity loginInfo =
          LoginInfoEntityEntity().fromJson(loginData);
      if (loginInfo.errorCode == 0) {
        //登录成功
        print("登陆成功");
        PrefsProvider.saveLoginInfo(loginInfo.data, phone, password);
        NavigatorUtils.goBack(context);
        NavigatorUtils.push(context, Routes.home);
      } else {
        ToastHelper.showWarning(loginInfo.errorMsg);
      }
    }, (errMsg) {
      setState(() {
        isLogin = false;
      });

      ToastHelper.showToast(errMsg);
    });
  }

  @override
  void dispose() {
    _onPhoneController.dispose();
    _onPasswordController.dispose();
    super.dispose();
  }
}
