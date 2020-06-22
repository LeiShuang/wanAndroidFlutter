import 'package:wanandroid/generated/json/base/json_convert_content.dart';

class SystemDataEntity with JsonConvert<SystemDataEntity> {
	List<SystemDataData> data;
	int errorCode;
	String errorMsg;
}

class SystemDataData with JsonConvert<SystemDataData> {
	List<SystemDataDatachild> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;
}

class SystemDataDatachild with JsonConvert<SystemDataDatachild> {
	List<dynamic> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;
}
