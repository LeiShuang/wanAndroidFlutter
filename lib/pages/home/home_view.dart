import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/pages/home/idnex_project.dart';
import 'package:wanandroid/pages/home/index_home.dart';
import 'package:wanandroid/pages/my_system/knowledge_system.dart';
import 'package:wanandroid/pages/web_guide/web_guide.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0; //默认索引0
  var currentPage; //当前页面
  PageController _controller;
  final List<String> _appBarTitles = ['首页', '项目', '体系', '个人中心'];

  //页面内容一般都是定值，这里用final 修饰，采用Cupertino的Ios风格
  final List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('项目')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.book), title: Text('体系')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('个人中心')),
  ];

  //当前页面内容，不给定页面类型，用数组装起来
  final List<Widget> tabViews = [
    HomePage(),
    ProjectPage(),
    SystemsPage(),
    WebGuidePage()
  ];

  @override
  void initState() {
    currentPage = tabViews[currentIndex];
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text(_appBarTitles[currentIndex]),
        ),*/
//      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          //一般都设置fixed
          type: BottomNavigationBarType.fixed,
          items: bottomItems,
          onTap: (index) => _controller.jumpToPage(index),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(), //viewPage禁止左右滑动
          onPageChanged: _pageChange,
          controller: _controller,
          children: tabViews,
        ));
  }

  void _pageChange(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
