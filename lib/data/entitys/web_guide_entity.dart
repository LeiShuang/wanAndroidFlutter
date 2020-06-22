import 'package:wanandroid/generated/json/base/json_convert_content.dart';

class WebGuideEntity with JsonConvert<WebGuideEntity> {
	List<WebGuideData> data;
	int errorCode;
	String errorMsg;
}

class WebGuideData with JsonConvert<WebGuideData> {
	List<WebGuideDataArticle> articles;
	int cid;
	String name;
}

class WebGuideDataArticle with JsonConvert<WebGuideDataArticle> {
	String apkLink;
	int audit;
	String author;
	bool canEdit;
	int chapterId;
	String chapterName;
	bool collect;
	int courseId;
	String desc;
	String descMd;
	String envelopePic;
	bool fresh;
	int id;
	String link;
	String niceDate;
	String niceShareDate;
	String origin;
	String prefix;
	String projectLink;
	int publishTime;
	int realSuperChapterId;
	int selfVisible;
	int shareDate;
	String shareUser;
	int superChapterId;
	String superChapterName;
	List<dynamic> tags;
	String title;
	int type;
	int userId;
	int visible;
	int zan;
}
