class StepItem {
  String title;
  String subtitle;
  bool done;

  StepItem({
    required this.title,
    required this.subtitle,
    this.done = false,
  });
}

class StepCategory {
  final String title;
  final String subtitle;
  final List<StepItem> steps;

  StepCategory({
    required this.title,
    required this.subtitle,
    required this.steps,
  });
}
