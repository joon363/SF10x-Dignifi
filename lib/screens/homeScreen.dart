import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:reentry/datas/stepsData.dart';
import 'package:reentry/models/stepsModel.dart';
import 'package:reentry/screens/chatbotScreen.dart';
import 'package:reentry/viewModels/stepsViewModel.dart';
import 'package:reentry/screens/playbookDetailScreen.dart';
import '../theme.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  value: 0.2,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: primaryColorLight,
                  color: Colors.white,
                ),),
              Text(
                "20%",
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
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _pageIndex = i),
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => ActivityProgressCard(category: categories[i]),
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
  final StepCategory category;
  const ActivityProgressCard({
    super.key,
    required this.category
  });

  @override
  State<ActivityProgressCard> createState() => _ActivityProgressCardState();
}

class _ActivityProgressCardState extends State<ActivityProgressCard> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StepsViewModel(category: widget.category),
      child: Builder(builder: (context) {
          final vm = context.watch<StepsViewModel>();
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
                              Provider.of<StepsViewModel>(context).category.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              Provider.of<StepsViewModel>(context).category.subtitle,
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
                          value: vm.progressPercent(),
                          strokeWidth: 4,
                          color: primaryColor,
                        ),
                        Text(
                          "${(vm.progressPercent() * 100).round()}%",
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
                          vm.progressText(),
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
                      value: vm.progressPercent(),
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
                        MaterialPageRoute(builder: (_) => PlaybookDetailScreen(category: widget.category,)),
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
  Widget smallButton(IconData icon, String title, String subtitle, BuildContext context){
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: primaryColor, size: 30,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatbotScreen()),
            );
          },
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: grayBoxDecoration,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smallButton(Icons.chat_bubble, "Chat with AI", "Get help with\nyour actions", context),
              smallButton(Icons.local_activity, "Find Resources", "Locate\nnearby services", context),
              smallButton(Icons.timer_rounded, "Set Reminders", "Stay on task\nwith tasks", context),
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




