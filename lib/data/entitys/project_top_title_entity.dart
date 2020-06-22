import 'package:wanandroid/generated/json/base/json_convert_content.dart';

class ProjectTopTitleEntity with JsonConvert<ProjectTopTitleEntity> {
	List<ProjectTopTitleData> data;
	int errorCode;
	String errorMsg;
}

class ProjectTopTitleData with JsonConvert<ProjectTopTitleData> {
	List<dynamic> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;
}
