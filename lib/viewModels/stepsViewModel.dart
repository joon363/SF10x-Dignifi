import 'package:flutter/material.dart';
import '../models/stepsModel.dart';

class StepsViewModel extends ChangeNotifier {
  final StepCategory category;

  StepsViewModel({required this.category});

  List<StepItem> get steps => category.steps;

  void toggle(int index) {
    steps[index].done = !steps[index].done;
    notifyListeners();
  }

  String statusOf(int index) {
    if (steps[index].done) return "Done";
    final firstUndone = steps.indexWhere((e) => !e.done);
    return (index == firstUndone) ? "Active" : "Pending";
  }

  double progressPercent() {
    final total = steps.length;
    final done = steps.where((e) => e.done).length;
    return done / total;
  }

  String progressText() {
    final done = steps.where((e) => e.done).length;
    final total = steps.length;
    return "$done/$total Steps";
  }
}
