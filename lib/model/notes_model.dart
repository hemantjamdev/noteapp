import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel {
  @HiveField(0)
  dynamic id;

  // String? userid;
  @HiveField(1)
  String? title;

  @HiveField(2)
  String? content;

  @HiveField(3)
  DateTime? createdon;

  NotesModel({
    this.createdon,
    this.title,
    this.id,
    this.content,
  });

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
