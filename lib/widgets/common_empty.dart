import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//通用空视图
class CommonEmptyPage extends StatefulWidget {
  const CommonEmptyPage({Key key, @required VoidCallback emptyCallBack})
      : _emptyRetry = emptyCallBack,
        super(key: key);
  final VoidCallback _emptyRetry;

  @override
  _CommonEmptyPageState createState() => _CommonEmptyPageState();
}

class _CommonEmptyPageState extends State<CommonEmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      height: double.infinity,
      child: InkWell(
        onTap: () {
          widget._emptyRetry;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              child: Image.asset("images/icon_empty.png"),
            ),
            Text(
              "暂无相关数据,请轻触重试...",
              style: TextStyle(
                  color: Colors.grey, fontSize: ScreenUtil().setSp(22)),
            )
          ],
        ),
      ),
    );
  }
}
