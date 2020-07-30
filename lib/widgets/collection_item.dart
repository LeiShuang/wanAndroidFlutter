import 'package:flutter/material.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';

class CollectionItem extends StatefulWidget {

  const CollectionItem({Key key, @required HomeArticleEntityDataData info})
      : _info = info,
        super(key: key);
  final HomeArticleEntityDataData _info;
  @override
  _CollectionItemState createState() {
    return _CollectionItemState();
  }
}

class _CollectionItemState extends State<CollectionItem> {
    bool hasCollection = true;
    void cancleCollect(
        BuildContext context, HomeArticleEntityDataData data) async {
      await DioHelper().post("lg/uncollect/${data.id}/json", {'originId':data.originId},
              (successCallBack) {
            setState(() {
              hasCollection = false;
            });
          }, (errorCallBack) {
            ToastHelper.showToast(errorCallBack);
          });
    }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          NavigatorUtils.goWebViewPage(context, widget._info.title.toString(),
              widget._info.link.toString());
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.yellow,
                  ),
                  Text(
                    widget._info.author,
                    style: TextStyle(color: Colors.green[400], fontSize: 14),
                  ),
                  Flexible(child: Container()),
                  Text(
                    '时间:${widget._info.niceDate}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  )
                ],
              ),
              Container(
                height: 10,
              ),
              Container(
                /* child: Html(
                  data: widget._info.title.toString(),*/
                   child: Text(
                     widget._info.title.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${widget._info.chapterName}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        //已经收藏,要取消收藏
                        cancleCollect(context, widget._info);
                      },
                      child: Icon(
                          hasCollection
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                          hasCollection ? Colors.red : Colors.grey),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


