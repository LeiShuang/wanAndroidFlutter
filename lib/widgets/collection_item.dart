import 'package:flutter/material.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/widgets/out_line_box.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({Key key, @required HomeArticleEntityDataData info})
      : _info = info,
        super(key: key);
  final HomeArticleEntityDataData _info;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,

      child: InkWell(
        onTap: () {
          NavigatorUtils.goWebViewPage(
              context, _info.title.toString(), _info.link.toString());
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _info.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutLineBox(title: _info.chapterName),
                ],
              ),
              Row(
                children: [
                  _info.author.isEmpty ?  new Container() :Icon(Icons.person, color: Colors.green),
                  _info.author.isEmpty ? new Container() : Text(_info.author),
                  Flexible(child: Container()),
                  Text(
                    "时间:${_info.niceDate}",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
