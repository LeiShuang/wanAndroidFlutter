import 'package:flutter/material.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';

class ProjectListItem extends StatefulWidget {
  final int _index;
  final HomeArticleEntityDataData _data;

  ProjectListItem(
      {Key key, @required int index, @required HomeArticleEntityDataData data})
      : _data = data,
        _index = index,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProjectListItemState();
  }
}

class _ProjectListItemState extends State<ProjectListItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 3,
      child: InkWell(
        onTap: () {
          NavigatorUtils.goWebViewPage(
              context, widget._data.title, widget._data.link);
        },
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: widget._index % 2 == 0 ? 120 : 160,
              width: 200,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget._data.envelopePic.toString()),
                      fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 10),
              child: Text(
                widget._data.title,
                style: TextStyle(color: Colors.black, fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.yellow,
                ),
                Flexible(child: Container()),
                Text(
                  widget._data.author.isNotEmpty
                      ? widget._data.author
                      : widget._data.shareUser,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(bottom: 5, top: 5),
              child: Text(
                widget._data.niceDate.toString(),
                style: TextStyle(color: Colors.black, fontSize: 12.0),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
