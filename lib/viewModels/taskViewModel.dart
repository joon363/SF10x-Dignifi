import 'package:flutter/material.dart';
import '../models/taskModel.dart';
import '../connections/apiCalls.dart';

class aTaskViewModel extends ChangeNotifier {
  final TaskGroup taskGroup;

  aTaskViewModel({required this.taskGroup});

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
    return done / total;
  }

  String progressPercent() {
    final total = steps.length;
    final done = steps.where((e) => e.done).length;
    return "${((done / total) * 100).round()}%";
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

  Task? getNextUndoneTask() {
    final undone = taskGroup.tasks
      .where((task) => !task.done)
      .toList()
    ..sort((a, b) => a.taskIdx.compareTo(b.taskIdx));

    return undone.isNotEmpty ? undone.first : null;
  }
}

class TaskGroupViewModel extends ChangeNotifier {

  final List<TaskGroup> groups;
  TaskGroupViewModel({required this.groups});

  int get totalDoneSteps {
    int count = 0;
    for (var category in groups) {
      for (var step in category.tasks) {
        if (step.done) count++;
      }
    }
    return count;
  }

  int get totalSteps {
    int count = 0;
    for (var category in groups) {
      count += category.tasks.length;
    }
    return count;
  }

  double get totalProgressRatio => totalDoneSteps / totalSteps;

  String get totalProgressPercent =>
      "${(totalProgressRatio * 100).round()}%";

  List<Task> steps(TaskGroup taskGroup){
    return taskGroup.tasks;
  }

  void toggle(int index, TaskGroup taskGroup) {
    steps(taskGroup)[index].done = !steps(taskGroup)[index].done;
    notifyListeners();
  }

  String statusOf(int index, TaskGroup taskGroup) {
    if (steps(taskGroup)[index].done) return "Done";
    final firstUndone = steps(taskGroup).indexWhere((e) => !e.done);
    return (index == firstUndone) ? "Active" : "Pending";
  }
  double progressRatio(TaskGroup taskGroup) {
    final total = steps(taskGroup).length;
    final done = steps(taskGroup).where((e) => e.done).length;
    return done / total;
  }

  String progressPercent(TaskGroup taskGroup) {
    final total = steps(taskGroup).length;
    final done = steps(taskGroup).where((e) => e.done).length;
    return "${((done / total) * 100).round()}%";
  }

  int doneCount(TaskGroup taskGroup) {
    final done = steps(taskGroup).where((e) => e.done).length;
    return done;
  }

  String progressText(TaskGroup taskGroup) {
    final done = steps(taskGroup).where((e) => e.done).length;
    final total = steps(taskGroup).length;
    return "$done/$total Steps";
  }

  Task? getNextUndoneTask(TaskGroup taskGroup) {
    final undone = taskGroup.tasks
        .where((task) => !task.done)
        .toList()
      ..sort((a, b) => a.taskIdx.compareTo(b.taskIdx));

    return undone.isNotEmpty ? undone.first : null;
  }
}
