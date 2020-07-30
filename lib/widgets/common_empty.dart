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
  String _emptyWidgetContent = "暂无数据~";
  String _emptyImgPath = "images/ic_empty.png"; //自己根据需求变更

  FontWeight _fontWidget = FontWeight.w600; //错误页面和空页面的字体粗度
  @override
  Widget build(BuildContext context) {
return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  color: Colors.black12,
                  image: AssetImage(_emptyImgPath),
                  width: 150,
                  height: 150,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(_emptyWidgetContent,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: _fontWidget,
                      )),
                ),Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: OutlineButton(
                      child: Text("重新加载",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: _fontWidget,
                          )),
                      onPressed: () => { widget._emptyRetry},
                    ))
              ],
            ),
          ),
        ),
      );
  }
}
