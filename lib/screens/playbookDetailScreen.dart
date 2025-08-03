import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/stepsViewModel.dart';
import '../models/stepsModel.dart';
import '../theme.dart';

class PlaybookDetailScreen extends StatelessWidget {
  final StepCategory category;
  const PlaybookDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StepsViewModel(category: category),
      child: SafeArea(
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
                  ActivityProgressCard(),
                  QuickActionsCard(),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActivityProgressCard extends StatelessWidget {
  const ActivityProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StepsViewModel>();

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(vm.category.title,
                        style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(vm.category.subtitle, style: TextStyle(color: Colors.black, fontSize: 14)),
                    ]),
                ]),
              Stack(alignment: Alignment.center, children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: vm.progressPercent(),
                      strokeWidth: 4,
                      color: primaryColor,
                    ),
                  ),
                  Text("${(vm.progressPercent() * 100).round()}%",
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
            ]),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Progress", style: TextStyle(color: Colors.black, fontSize: 12)),
              Text(vm.progressText(),
                style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          LinearProgressIndicator(
            minHeight: 10,
            value: vm.progressPercent(),
            borderRadius: BorderRadius.circular(10),
            backgroundColor: boxGrayColor,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StepsViewModel>();

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
            children: List.generate(vm.steps.length, (i) {
                final step = vm.steps[i];
                final status = vm.statusOf(i);
                final color = step.done
                  ? Colors.green[300]
                  : (status == "Active" ? primaryColor : Colors.grey[300]);

                return InkWell(
                  onTap: () => vm.toggle(i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: step.done,
                          onChanged: (_) => vm.toggle(i),
                          activeColor: Colors.green[300],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(step.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  decoration: step.done ? TextDecoration.lineThrough : null)),
                              Text(step.subtitle, style: TextStyle(color: Colors.grey)),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color, borderRadius: BorderRadius.circular(20)),
                                child: Text(status, style: TextStyle(fontSize: 12, color: status == "Active" ? Colors.white : Colors.black)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
          )
        ],
      ),
    );
  }
}
