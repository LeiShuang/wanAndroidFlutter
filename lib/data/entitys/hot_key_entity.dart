import 'package:wanandroid/generated/json/base/json_convert_content.dart';

class HotKeyEntity with JsonConvert<HotKeyEntity> {
	List<HotKeyEntityData> data;
	int errorCode;
	String errorMsg;
}

class HotKeyEntityData with JsonConvert<HotKeyEntityData> {
	int id;
	String link;
	String name;
	int order;
	int visible;
}
