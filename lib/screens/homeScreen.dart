import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 100,
          height: 50,
          child: SvgPicture.asset('assets/your_icon.svg'),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: boxGrayColor,
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                spacing: 16,
                children: [
                  WelcomeCard(),
                  PageViewCard(),
                  QuickActionsCard(),
                  RecentActivityCard(),
                  SizedBox(height: 50,)
                ],
              ),
            ),
          ],
        ),)
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
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            color: primaryColor
          //border: Border.all(color: primaryColor, width: 2),
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
            itemBuilder: (_, i) => ActivityProgressCard(),
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

class ActivityProgressCard extends StatelessWidget {
  const ActivityProgressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: Colors.white,
          border: Border.all(color: dividerNormal, width: 1),
        ),
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
                          "IDs & Benefits",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Essential Documentation",
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
                      value: 0.7,
                      strokeWidth: 4,
                      color: primaryColor,
                    ),
                    Text(
                      "70%",
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
                      "6/8 Steps",
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
                  value: 0.2,
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
                  // Action
                },
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                //highlightColor: primaryColorLight,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    //color: Colors.green !DO NOT ADD COLOR TO CONTAINER
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
}

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: Colors.white,
          border: Border.all(color: dividerNormal, width: 1),
        ),
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
                Column(
                  children: [
                    Icon(Icons.chat_bubble, color: primaryColor, size: 30,),
                    Text(
                      "Chat with AI",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "Get help with\nyour actions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.local_activity, color: primaryColor, size: 30,),
                    Text(
                      "Find Resources",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "Locate\nnearby services",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.timer_rounded, color: primaryColor, size: 30,),
                    Text(
                      "Set Reminders",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "Stay on task\nwith tasks",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        color: Colors.white,
        border: Border.all(color: dividerNormal, width: 1),
      ),
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




