import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/taskViewModel.dart';
import '../models/taskModel.dart';
import '../theme.dart';

class PlaybookDetailScreen extends StatelessWidget {
  final TaskGroup group;
  const PlaybookDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("Playbook Detail",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ActivityProgressCard(group: group,),
                QuickActionsCard(group: group),
                SizedBox(height: 3 * 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActivityProgressCard extends StatelessWidget {
  final TaskGroup group;
  const ActivityProgressCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskGroupViewModel>();

    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(group.groupName,
                        style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(group.groupExplanation, style: TextStyle(color: Colors.black, fontSize: 14)),
                    ]),
                ]),
              Stack(alignment: Alignment.center, children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: vm.progressRatio(group),
                      strokeWidth: 4,
                      color: secondaryColor,
                    ),
                  ),
                  Text(vm.progressPercent(group),
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
            ]),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Progress", style: TextStyle(color: Colors.black, fontSize: 12)),
              Text(vm.progressText(group),
                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          LinearProgressIndicator(
            minHeight: 10,
            value: vm.progressRatio(group),
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            backgroundColor: boxGrayColor,
            color: secondaryColor,
          ),
        ],
      ),
    );
  }
}

class QuickActionsCard extends StatelessWidget {
  final TaskGroup group;
  const QuickActionsCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskGroupViewModel>();

    return Container(
      decoration: grayBoxDecoration,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Action Steps",
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(group.tasks.length, (i) {
                final step = group.tasks[i];
                final status = vm.statusOf(i, group);
                final color = step.done
                  ? secondaryColor
                  : (status == "Active" ? primaryColor : Colors.grey[300]);

                return InkWell(
                  onTap: () => vm.toggle(i, group),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: step.done,
                          onChanged: (_) {
                            vm.toggle(i, group);
                          },
                          activeColor: secondaryColor,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(step.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  decoration: step.done ? TextDecoration.lineThrough : null)),
                              Text(step.explanation, style: TextStyle(color: Colors.grey)),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color, borderRadius: BorderRadius.circular(defaultBorderRadius)),
                                child: Text(status, style: TextStyle(fontSize: 12, color: status == "Active" ? Colors.white : Colors.black)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
