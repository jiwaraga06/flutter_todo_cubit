class TodoModel {
  int id;
  String message;
  String isCompleted;
  String createdAt;
  String updatedAt;

  TodoModel({
    required this.id,
    required this.message,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  // TodoModel.fromJson(Map json)
  //     : id = json["id"] as int,
  //       message = json["message"],
  //       isCompleted = json["isCompleted"].toString(),
  //       createdAt = json['created_at'],
  //       updatedAt = json['updated_at'];

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["id"],
      message: json["message"],
      isCompleted: json["isCompleted"].toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
