class NotesModel {
  String? id;
 // String? userid;
  String? title;
  String? content;
  DateTime? createdon;

  NotesModel({this.createdon, this.title, this.id, this.content, });

  NotesModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
   // userid = map["userid"];
    title = map["title"];
    content = map["content"];
    createdon = DateTime.tryParse(map["createdon"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
     // "userid": userid,
      "title": title,
      "content": content,
      "createon": createdon
    };
  }
}
