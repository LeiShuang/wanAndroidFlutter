import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/pages/home/home_view.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _countDown();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
          image: DecorationImage(
              image: AssetImage("images/splash_bg4.jpg"), fit: BoxFit.fill)),
    );
  }

  void _countDown() {
    var duration = Duration(seconds: 1);
     Future.delayed(duration,_gotoHomePage);
  }

  void  _gotoHomePage(){
    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(builder: (context) => HomeView()),
          (route) => route == null,
    );
  }
}
