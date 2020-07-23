import 'package:flutter/material.dart';
import 'package:wanandroid/helper/toast_helper.dart';

class OutLineBox extends StatelessWidget {
  const OutLineBox({Key key, @required String title, @required String link})
      : _title = title,
        _linkUrl = link,
        super(key: key);
  final String _title;
  final String _linkUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(_linkUrl.isNotEmpty){
          ToastHelper.showToast("点击了$_title");
        }
      },
      child: Container(
        height: 22,
        padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
        margin: EdgeInsets.only(left: 5, right: 5),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(

         border: Border.all(color: Colors.red[400]),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          _title,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
