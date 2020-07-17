import 'dart:async';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/data/entitys/login_info_entity_entity.dart';

class PrefsProvider {
  static const String SP_USER_NAME = 'user_name';
  static const String SP_PASSWORD = "pass_word";
  static const String USER_NAME = "username";
  static const String PASS_WORD = "password";
  static const String SP_ADMIN = "admin";
  static const String SP_CHAPTERTOPS = "chapterTops";
  static const String SP_COLLECTIDS = "collectIds";
  static const String SP_EMAIL = "email";
  static const String SP_ICON = "icon";
  static const String SP_ID = "id";
  static const String SP_NICAKNAME = "nickname";
  static const String SP_PUBLIC_NAME = "publicName";
  static const String SP_TOKEN = "token";
  static const String SP_TYPE = "type";
  static const String SP_COOKIE = "cookie";
  static const String SP_HAS_LOGIN = "handLogin";

  static Future<void> saveLoginInfo(LoginInfoEntityData infoEntityData,
      String userName, String passWord) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setString(SP_USER_NAME, userName)
      ..setString(SP_PASSWORD, passWord)
      ..setString(USER_NAME, infoEntityData.username)
      ..setString(PASS_WORD, infoEntityData.password)
      ..setBool(SP_ADMIN, infoEntityData.admin)
      ..setString(SP_EMAIL, infoEntityData.email)
      ..setString(SP_ICON, infoEntityData.icon)
      ..setInt(SP_ID, infoEntityData.id)
      ..setString(SP_NICAKNAME, infoEntityData.nickname)
      ..setString(SP_PUBLIC_NAME, infoEntityData.publicName)
      ..setString(SP_TOKEN, infoEntityData.token)
      ..setInt(SP_TYPE, infoEntityData.type)
      ..setString(SP_COOKIE, "loginUserName=$userName,loginPassWord=$passWord")
      ..setBool(SP_HAS_LOGIN, true);
  }

  static Future<void> clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setString(SP_USER_NAME, '')
      ..setString(SP_PASSWORD, '')
      ..setBool(SP_ADMIN, false)
      ..setStringList(SP_CHAPTERTOPS, null)
      ..setStringList(SP_COLLECTIDS, null)
      ..setString(SP_EMAIL, '')
      ..setString(SP_ICON, "")
      ..setInt(SP_ID, -1)
      ..setString(SP_NICAKNAME, '')
      ..setString(SP_PUBLIC_NAME, '')
      ..setString(SP_TOKEN, '')
      ..setInt(SP_TYPE, -1)
      ..setString(USER_NAME, '')
      ..setString(PASS_WORD, '')
      ..setString(SP_COOKIE, "")
      ..setBool(SP_HAS_LOGIN, false);
  }

  static Future<LoginInfoEntityData> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    bool hasLogin = sp.getBool(SP_HAS_LOGIN);
    if (hasLogin == null || !hasLogin) {
      return null;
    } else {
      LoginInfoEntityData userInfo = LoginInfoEntityData();
      userInfo.username = sp.getString(SP_USER_NAME);
      userInfo.type = sp.getInt(SP_TYPE);
      userInfo.icon = sp.getString(SP_ICON);
      userInfo.id = sp.getInt(SP_ID);
      userInfo.nickname = sp.getString(SP_NICAKNAME);
      userInfo.password = sp.getString(SP_PASSWORD);
      userInfo.publicName = sp.getString(SP_PUBLIC_NAME);
      userInfo.token = sp.getString(SP_TOKEN);
      userInfo.type = sp.getInt(SP_TYPE);
      return userInfo;
    }
  }

  static Future<Map<String, String>> getCookies() async {
    Map<String, String> cookieMap = Map();
    SharedPreferences sp = await SharedPreferences.getInstance();
    cookieMap["Cookice"] = sp.getString(SP_COOKIE);
    return cookieMap;
  }

  static Future<bool> hasLogin()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
     bool hasLogin = sp.getBool(SP_HAS_LOGIN);
     return hasLogin;

  }
}
