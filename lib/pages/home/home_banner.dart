import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/data/entitys/banner_entity_entity.dart';
import 'package:wanandroid/helper/toast_helper.dart';
import 'package:wanandroid/routers/fluro_navigator.dart';

class HomeTopBanner extends StatelessWidget {
  final List<BannerEntityData> _bannerLists;

  const HomeTopBanner({Key key, @required List<BannerEntityData> data})
      : _bannerLists = data,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(500),
      child: Swiper(
        itemCount: _bannerLists.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(_bannerLists[index].imagePath, fit: BoxFit.fill);
        },
        pagination: SwiperPagination(),
        autoplay: true,
        autoplayDisableOnInteraction: true,
        onTap: (index) {
          NavigatorUtils.goWebViewPage(
              context, _bannerLists[index].title, _bannerLists[index].url);
        },
      ),
    );
  }
}
