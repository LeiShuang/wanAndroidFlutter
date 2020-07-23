import 'package:flutter/material.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
//首页ListView的Item布局
class HomeArticleWidget extends StatelessWidget {
  const HomeArticleWidget({Key key, @required HomeArticleEntityDataData data})
      : _data = data,
        super(key: key);
  final HomeArticleEntityDataData _data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          NavigatorUtils.goWebViewPage(context, _data.title.toString(), _data.link.toString());
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  _data.title.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Row(
                children: <Widget>[
                  _itemOutLine(_data.superChapterName, _data.projectLink),
                  _itemOutLine(_data.chapterName, _data.projectLink),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.yellow,
                  ),
                  Text(
                    _data.author == "" ? _data.shareUser : _data.author,
                    style: TextStyle(color: Colors.green[400], fontSize: 12),
                  ),
                  Flexible(child: Container()),
                  Text(
                    '时间:${_data.niceDate}',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemOutLine(String superChapterName, String projectLink) {
    return GestureDetector(
      onTap: () {
        if (projectLink != "") {
          ToastHelper.showToast("点击了tab");
        }
      },
      child:Container(
        height: 22,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 5, right: 5),
        padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red[400]),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
         superChapterName,
          style: TextStyle(fontSize: 12),
        ),
      ) ,
    );
  }

}

