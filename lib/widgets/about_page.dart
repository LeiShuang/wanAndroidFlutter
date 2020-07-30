import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('关于'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '作者:雷双(一名Android开发工程师)',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('本APP使用的Api均为 玩安卓 网站提供,仅供学习交流,禁止用于任何商业用途',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              SizedBox(
                height: 30,
              ),
              Text('QQ:939952154',
                  style: TextStyle(color: Colors.blue, fontSize: 16)),
              SizedBox(
                height: 30,
              ),
              Text('微信:leishuang939952154',
                  style: TextStyle(color: Colors.blue, fontSize: 16)),
              SizedBox(
                height: 30,
              ),
              Text('Email:939952154@qq.com',
                  style: TextStyle(color: Colors.blue, fontSize: 16)),

            ],
          ),
        )
      );
  }
}
