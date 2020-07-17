import 'package:wanandroid/generated/json/base/json_convert_content.dart';

class LoginInfoEntityEntity with JsonConvert<LoginInfoEntityEntity> {
	LoginInfoEntityData data;
	int errorCode;
	String errorMsg;
}

class LoginInfoEntityData with JsonConvert<LoginInfoEntityData> {
	bool admin;
	List<dynamic> chapterTops;
	List<int> collectIds;
	String email;
	String icon;
	int id;
	String nickname;
	String password;
	String publicName;
	String token;
	int type;
	String username;
}
