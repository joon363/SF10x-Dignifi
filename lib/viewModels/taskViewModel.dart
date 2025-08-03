import 'package:flutter/material.dart';
import '../models/taskModel.dart';
import '../connections/apiCalls.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskGroup taskGroup;

  TaskViewModel({required this.taskGroup});

  List<Task> get steps => taskGroup.tasks;

  void toggle(int index) {
    steps[index].done = !steps[index].done;
    notifyListeners();
  }

  String statusOf(int index) {
    if (steps[index].done) return "Done";
    final firstUndone = steps.indexWhere((e) => !e.done);
    return (index == firstUndone) ? "Active" : "Pending";
  }
  double progressRatio() {
    final total = steps.length;
    final done = steps.where((e) => e.done).length;
    return done/total;
  }

  String progressPercent() {
    final total = steps.length;
    final done = steps.where((e) => e.done).length;
    return "${((done / total)*100).round()}%";
  }

  int doneCount() {
    final done = steps.where((e) => e.done).length;
    return done;
  }

  String progressText() {
    final done = steps.where((e) => e.done).length;
    final total = steps.length;
    return "$done/$total Steps";
  }
}

class TaskGroupViewModel extends ChangeNotifier {
  late List<TaskGroup> groups;

  int _doneTasks = 0;
  int _totalTasks = 0;

  Future<void> fetch() async {
    final res = await getGroupsData();
    await setData(res);
  }
  Future<void> setData(List<TaskGroup> newGroups) async {
    groups = newGroups;
    await _recalculate();
  }

  Future<void> _recalculate() async {
    _doneTasks = 0;
    _totalTasks = 0;

    for (var category in groups) {
      for (var step in category.tasks) {
        _totalTasks++;
        if (step.done) _doneTasks++;
      }
    }
  }

  void update() {
    _recalculate();
    notifyListeners();
  }

  int get totalDoneSteps => _doneTasks;
  int get totalSteps => _totalTasks;
  double get totalProgressRatio => _doneTasks/_totalTasks;
  String get totalProgressPercent => "${((totalDoneSteps / totalSteps)*100).round()}%";
}
