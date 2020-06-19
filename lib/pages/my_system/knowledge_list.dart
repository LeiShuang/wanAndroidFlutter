import 'package:flutter/material.dart';
import 'package:wanandroid/data/entitys/system_list_entity.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';
import 'net.dart';

class KnowledgeDetailList extends StatefulWidget {
  int knowledgeId;
  String title;

  KnowledgeDetailList(this.knowledgeId, this.title);

  @override
  _KnowledgeDetailListState createState() => _KnowledgeDetailListState();
}

class _KnowledgeDetailListState extends State<KnowledgeDetailList> {

  int _currentPage = 0;
  bool _isOver = false;
  List<SystemListDataData> _mList = new List();
  bool _isFirstLoad;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _isFirstLoad = true;
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //加载更多
        if(!_isOver){
          ToastHelper.showToast("加载更多");
          _loadData();
        }else{
          ToastHelper.showToast("没有更多了哟");
        }

      }
    });

    _loadData();
  }

  /*
  * 加载数据/加载更多
  * */
   _loadData(){
      _isFirstLoad = true;
      getSystemDetailList(_currentPage,widget.knowledgeId).then((value) => {
        setState((){
          _isFirstLoad = false;
          _currentPage++;
          _isOver = value.data.over;
          _mList.addAll(value.data.datas) ;
        })
      });
  }

  /*
  * 刷新数据
  * */
  Future<void> _refreshData() async{
    _isFirstLoad = true;
    _currentPage = 0;
    _mList.clear();
    await Future.delayed(const Duration(seconds: 2),(){
      getSystemDetailList(_currentPage, widget.knowledgeId).then((value) => {
        setState((){
          _isFirstLoad = false;
          _currentPage++;
          _isOver = value.data.over;
          _mList.addAll(value.data.datas) ;
          ToastHelper.showToast("刷新成功");
        })
      });
    });

    return;
  }



  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
//        automaticallyImplyLeading: false,
      ),
      body:Stack(
        children: [
          Offstage(
            offstage: !_isFirstLoad,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Offstage(
            offstage: _isFirstLoad,
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.separated(
                controller: _scrollController,
                separatorBuilder: (context,index){
                  Widget divider=Divider(color: Colors.blue,);
                  return divider;
                },
                itemCount: _mList.length,
                itemBuilder: (context,index){
                  return _buildItemView(index);
                },
              ),
            ),
          )
        ],
      )

    );
  }


  _buildItemView(int index){
    return GestureDetector(
      onTap: (){
        String url = _mList[index].link;
        String title = _mList[index].title;
        NavigatorUtils.goWebViewPage(context, title, url);
      },
      child:   Container(
        margin: const EdgeInsets.all(8.0),
        height: 60.0,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    _mList[index].title,
                    style: TextStyle(fontSize: 16),
                  ),
                )
            ),
            Expanded(
              flex: 1,
              child: Text(
                "日期："+_mList[index].niceDate,
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );

  }
}
