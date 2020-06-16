import 'package:dio/dio.dart';
import 'package:wanandroid/generated/json/base/json_convert_content.dart';
import 'dart:convert';
import 'file:///E:/wanAndroidFlutter/lib/data/entitys/system_data_entity.dart';
import 'file:///E:/wanAndroidFlutter/lib/data/entitys/web_guide_entity.dart';

Future<SystemDataEntity> getSystemList() async{
  Response systemResponse = await Dio().get("https://www.wanandroid.com/tree/json");
  var result = json.decode(systemResponse.toString());
  SystemDataEntity entity = JsonConvert.fromJsonAsT<SystemDataEntity>(result);
  return entity;
}

Future<WebGuideEntity> getWebGuideList() async{
  Response guideResponse = await Dio().get("https://www.wanandroid.com/navi/json");
  var result = json.decode(guideResponse.toString());
  WebGuideEntity entity = JsonConvert.fromJsonAsT<WebGuideEntity>(result);
  return entity;
}