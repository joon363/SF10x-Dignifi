import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reentry/models/taskModel.dart';
import 'package:reentry/screens/chatbotScreen.dart';
import 'package:reentry/screens/phoneCallScreen.dart';
import 'package:reentry/viewModels/taskViewModel.dart';
import 'package:reentry/screens/playbookDetailScreen.dart';
import '../theme.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<TaskGroupViewModel>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          } else {
            return SafeArea(
              top: false,
              child: Scaffold(
                appBar: AppBar(
                  leading: Padding(padding: EdgeInsets.all(8), child: SvgPicture.asset(width: 30, height: 40, 'assets/images/logo.svg')),
                  title: Text(
                    "Dignifi",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 0.1
                    ),
                  ),
                  titleSpacing: 0,
                  centerTitle: false,
                ),
                backgroundColor: boxGrayColor,
                body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        spacing: 16,
                        children: [
                          Container(),
                          WelcomeCard(),
                          PageViewCard(),
                          QuickActionsCard(),
                          RecentActivityCard(),
                          SizedBox(height: 50,)
                        ],
                      ),
                    ),
                  ],
                )
              ),
            );
          }
        }
        return Text('Error: Cannot Reach Here');
      }
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskGroupViewModel>();
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColorDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          Text(
            "Welcome back, Terran!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(child: LinearProgressIndicator(
                  minHeight: 10,
                  value: vm.totalProgressRatio,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: primaryColorLight,
                  color: Colors.white,
                ),),
              Text(
                vm.totalProgressPercent,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],),
          Text(
            "Great momentum!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      )
    );
  }
}

class PageViewCard extends StatefulWidget {
  const PageViewCard({
    super.key,
  });

  @override
  State<PageViewCard> createState() => _PageViewCardState();
}

class _PageViewCardState extends State<PageViewCard> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskGroupViewModel>();
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _pageIndex = i),
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => ActivityProgressCard(group: vm.groups[i]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _pageIndex == i ? Colors.black : Colors.grey,
                ),
              );
            }),
        )
      ],
    );
  }
}

class ActivityProgressCard extends StatefulWidget {
  final TaskGroup group;
  const ActivityProgressCard({
    super.key,
    required this.group
  });

  @override
  State<ActivityProgressCard> createState() => _ActivityProgressCardState();
}

class _ActivityProgressCardState extends State<ActivityProgressCard> {
  @override
  Widget build(BuildContext context) {
    final stepsCategoryVM = context.watch<TaskGroupViewModel>();
    return ChangeNotifierProvider(
      create: (_) => TaskViewModel(taskGroup: widget.group),
      child: Builder(builder: (context) {
          final tasksVM = context.watch<TaskViewModel>();
          return Container(
            decoration: grayBoxDecoration,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(right: 8),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 24,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Icon(Icons.check, color: primaryColor, size: 30,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasksVM.taskGroup.groupName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              tasksVM.taskGroup.groupExplanation,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: tasksVM.progressRatio(),
                          strokeWidth: 4,
                          color: primaryColor,
                        ),
                        Text(
                          tasksVM.progressPercent(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progress",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          tasksVM.progressText(),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      minHeight: 10,
                      value: tasksVM.progressRatio(),
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: boxGrayColor,
                      color: primaryColor,
                    ),
                  ],
                ),
                Material(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          ChangeNotifierProvider.value(
                            value: stepsCategoryVM, // 기존 ViewModel 인스턴스
                            child: PlaybookDetailScreen(category: widget.group),        // PageB가 이 ViewModel을 사용할 수 있음
                          )
                        ),
                      ).then((_) {
                            setState(() {
                              });
                          });
                    },
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultBorderRadius),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Continue Playbook",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          );
        }
      )
    );
  }
}

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({
    super.key,
  });

  Widget smallButton(IconData icon, String title, String subtitle, BuildContext context, int index) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        elevation: 0,
        child: InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatbotScreen()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PhoneCallScreen()),
              );
            }
          },
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          //highlightColor: Colors.red,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              border: Border.all(color: primaryColor, width: 1),
            ),
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                Icon(icon, color: primaryColor, size: 35,),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: grayBoxDecoration,
      //padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              smallButton(Icons.chat_bubble, "Chat with AI", "Get help with\nyour actions", context, 0),
              smallButton(Icons.phone, "Talk with AI", "Trouble texting?\nMake a call now.", context, 1),
            ],
          )
        ],
      )
    );
  }
}

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: grayBoxDecoration,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          Column(
            spacing: 8,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Icon(Icons.check_circle, color: primaryColor, size: 30,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Completed: Obtain State ID",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "IDs & Benefits · 2 hours ago",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Icon(Icons.check, color: primaryColor, size: 30,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Milestone Reached: 20% progress",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Overall Progress · Yesterday",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      )
    );
  }
}




