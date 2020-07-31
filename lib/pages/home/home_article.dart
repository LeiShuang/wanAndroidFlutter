import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/config/dio_err_code.dart';
import 'package:wanandroid/data/entitys/home_article_entity_entity.dart';
import 'package:wanandroid/helper/dio_helper.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'package:wanandroid/routers/routers.dart';

//首页ListView的Item布局
class HomeArticleWidget extends StatefulWidget {
  const HomeArticleWidget({Key key, @required HomeArticleEntityDataData data})
      : _data = data,
        super(key: key);
  final  HomeArticleEntityDataData _data;
  @override
  _HomeArticleWidgetState createState() {
    return _HomeArticleWidgetState();
  }
}

class  _HomeArticleWidgetState extends State<HomeArticleWidget>{
  @override
  void initState() {
    super.initState();
    print("当前item的数据--->${widget._data.toJson()}");
  }
  @override
  Widget build(BuildContext context) {
   return Card(
     elevation: 3,
     child: InkWell(
       onTap: () {
         NavigatorUtils.goWebViewPage(
             context, widget._data.title.toString(),  widget._data.link.toString());
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
                   widget._data.author == "" ?  widget._data.shareUser :  widget._data.author,
                   style: TextStyle(color: Colors.green[400], fontSize: 14),
                 ),
                 widget._data.type == 1
                     ? _itemOutLine("置顶", Colors.red)
                     : new Container(),
                 widget._data.fresh
                     ? _itemOutLine("NEW", Colors.red)
                     : new Container(),
                 Flexible(child: Container()),
                 Text(
                   '时间:${ widget._data.niceDate}',
                   style: TextStyle(color: Colors.grey[600], fontSize: 12),
                 )
               ],
             ),
             Container(
               height: 10,
             ),
             Container(
               child: Text(
                 widget._data.title.toString(),
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
                   "${ widget._data.superChapterName}-${ widget._data.chapterName}",
                   style: TextStyle(color: Colors.grey[600], fontSize: 12),
                 ),
                 Expanded(
                     child: Align(
                       alignment: Alignment.centerRight,
                       child: GestureDetector(
                         onTap: () {
                           if ( widget._data.collect) {
                             //已经收藏,要取消收藏
                             cancleCollect(context,  widget._data);
                           }else{
                             addCollect(context,  widget._data);
                           }
                         },
                         child: Icon(
                             widget._data.collect
                                 ? Icons.favorite
                                 : Icons.favorite_border,
                             color:  widget._data.collect ? Colors.red : Colors.grey),
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
  void cancleCollect(
      BuildContext context, HomeArticleEntityDataData data) async {
    await DioHelper().post("lg/uncollect_originId/${data.id}/json", null,
            (successCallBack) {
      this.setState(() {
        widget._data.collect = false;
      });
        }, (errorCallBack) {
          ToastHelper.showToast(errorCallBack);
        });
  }

  void addCollect(BuildContext context, HomeArticleEntityDataData data) async {
    await DioHelper().post("lg/collect/${data.id}/json", null,
            (successCallBack) {
      if(successCallBack['errorCode'] == ResultCode.RELOGIN){
        ToastHelper.showWarning("请先登录!");
        NavigatorUtils.push(context, Routes.loginPage);
      }else{
        this.setState(() {
          widget._data.collect = true;
        });
      }
        }, (errorCallBack) {
          ToastHelper.showToast(errorCallBack);
        });
  }
}


  Widget _itemOutLine(String superChapterName, Color color) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 5, right: 5),
      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        superChapterName,
        style: TextStyle(fontSize: 12, color: color),
      ),
    );
  }



