class Task {
  int taskIdx;
  String title;
  String explanation;
  bool done;

  Task({
    required this.taskIdx,
    required this.title,
    required this.explanation,
    this.done = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskIdx: json['taskidx'],
      title: json['title'],
      explanation: json['explanation'],
      done: json['isDone'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskidx': taskIdx,
      'title': title,
      'explanation': explanation,
      'isDone': done,
    };
  }
}

class TaskGroup {
  final int groupId;
  final String groupName;
  final String groupExplanation;
  final List<Task> tasks;

  TaskGroup({
    required this.groupId,
    required this.groupName,
    required this.groupExplanation,
    required this.tasks,
  });

  factory TaskGroup.fromJson(Map<String, dynamic> json) {
    return TaskGroup(
      groupId: json['groupID'],
      groupName: json['groupName'],
      groupExplanation: json['groupExplanation'],
      tasks: (json['tasks'] as List)
        .map((stepJson) => Task.fromJson(stepJson))
        .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupID': groupId,
      'groupName': groupName,
      'groupExplanation': groupExplanation,
      'tasks': tasks.map((step) => step.toJson()).toList(),
    };
  }
}
