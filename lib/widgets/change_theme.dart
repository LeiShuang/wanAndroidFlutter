import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid/utils/event_bus.dart';
import 'package:wanandroid/utils/prefer_constants.dart';
import 'package:wanandroid/utils/theme_utils.dart';

class ChangeThemePage extends StatefulWidget {
  @override
  _ChangeThemePageState createState() => _ChangeThemePageState();
}

class _ChangeThemePageState extends State<ChangeThemePage> {
  List<Color> colors = ThemeUtils.supportColors;
  int selected;

  @override
  void initState() {
    super.initState();
    PrefsProvider.getThemeColor().then((i) {
      print("当前颜色值的i为$i");
      setState(() {
        selected = i;
        if (i == null) {
          selected = 0;
        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "切换主题",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(4.0),
        child: GridView.count(
          crossAxisCount: 4,
          children: List.generate(colors.length, (index) {
            return InkWell(
              onTap: () {
                PrefsProvider.changeThemeColor(index);
                ThemeUtils.currentColorTheme = colors[index];
                eventBus.fire(ChangeTheThemeEvent(colors[index]));
                setState(() {
                  selected = index;
                });
              },
              child: Container(
                alignment: Alignment.topRight,
                color: colors[index],
                margin: EdgeInsets.all(4.0),
                child:  selected == index
                    ? Image.asset(
                        "images/theme_choice.png",
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setWidth(50),
                      )
                    : new Container(),
              ),
            );
          }),
        ),
      ),
    );
  }
}
