import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/data/api/requeststring.dart';
import 'package:wanandroid/data/entitys/login_info_entity_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/routers/routers.dart';
import 'package:wanandroid/utils/prefer_constants.dart';
import 'package:wanandroid/utils/theme_utils.dart';

//注册界面
class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController(text: '');
  final passWordController = TextEditingController(text: '');
  final rePassWordController = TextEditingController(text: '');
  bool obpassWord = true;
  bool obUserName = false;

  //是否正在注册
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    var loadingView;
    if (isRegistering) {
      loadingView = Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[CupertinoActivityIndicator(), Text("注册中，请稍等...")],
        ),
      ));
    } else {
      loadingView = Center();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '注册',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50, bottom: 10),
              child: Image.asset(
                "images/logo.png",
                width: 100,
                height: 100,
              ),
            ),
            createInputBox(
                userNameController, Icons.person, Icons.close, false),
            createInputBox(passWordController, Icons.lock_outline,
                Icons.visibility, true, ),
            createInputBox(rePassWordController, Icons.lock_outline,
                Icons.visibility, true, ),
            Padding(
              padding:
                  EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    height: 45,
                    child: RaisedButton(
                      onPressed: () {
                        if (isRegistering) {
                          return;
                        }
                        if (userNameController.text.trim().toString().isEmpty ||
                            passWordController.text.trim().toString().isEmpty ||
                            rePassWordController.text
                                .trim()
                                .toString()
                                .isEmpty) {
                          ToastHelper.showWarning("账号或者密码为空!");
                          return;
                        } else if (passWordController.text.trim().toString() !=
                            rePassWordController.text.trim().toString()) {
                          ToastHelper.showWarning("两次输入密码不一致!");
                          return;
                        }
                        _register();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        '注册',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: ThemeUtils.defaultColor,
                      highlightColor: ThemeUtils.defaultColor,
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: <Widget>[Expanded(child: loadingView)],
            ))
          ],
        ));
  }

  createInputBox(TextEditingController controller, IconData leftIcon,
      IconData rightIcon, bool isPassWord) {
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
            obscureText: isPassWord ? obpassWord : obUserName,
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
                if (isPassWord) {
                  setState(() {
                    obpassWord = !obpassWord;
                  });
                } else {
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
          )
        ],
      ),
    );
  }

  void _register() async {
    setState(() {
      isRegistering = true;
    });
    String username = userNameController.text.trim().toString();
    String password = passWordController.text.trim().toString();
    String rePassword = rePassWordController.text.trim().toString();
    await DioHelper().post(RequestUrl.register, {
      'username': username,
      'password': password,
      'repassword': rePassword,
    }, (successCallBack) {
      setState(() {
        isRegistering = false;
      });
      if (successCallBack != null) {
        LoginInfoEntityEntity registerInfo =
            LoginInfoEntityEntity().fromJson(successCallBack);
        if (registerInfo.errorCode == 0) {
          print("注册成功");
          PrefsProvider.saveLoginInfo(registerInfo.data, username, password);
          NavigatorUtils.goBack(context);
          NavigatorUtils.push(context, Routes.home);
        }
      }
    }, (errorCallBack) {
      setState(() {
        isRegistering = false;
      });

      ToastHelper.showWarning(errorCallBack.toString());
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    rePassWordController.dispose();
    super.dispose();
  }
}
