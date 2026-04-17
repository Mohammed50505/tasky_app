class TaskModel {
  int id;
  final String taskName;
  final String taskDescription;
  final bool isHighpriority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighpriority,
   this.isDone=false,
  });

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighpriority": isHighpriority,
      "isDone": isDone,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      taskName: json["taskName"] ?? "",
      taskDescription: json["taskDescription"] ?? "",
      isHighpriority: json["isHighpriority"] ?? false,
      isDone: json["isDone"] ?? false, 
    );
  }
}