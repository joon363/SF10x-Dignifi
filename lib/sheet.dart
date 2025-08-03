import 'package:flutter/material.dart';
import 'theme.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> dummyData = [
  {
    'title': "Data1",
    'data': "information 1"
  },
  {
    'title': "Data2",
    'data': "information 2"
  },
  {
    'title': "Data3",
    'data': "information 3"
  },
  ];

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Column(
                children: [
                  Material(
                    color: primaryColor,
                    shape: const CircleBorder(),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        // Action
                      },
                      customBorder: const CircleBorder(),
                      //highlightColor: Colors.red,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Text("Circular Button")
                ],
              ),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey, // 배경색 (이미지 로드 안 됐을 때 표시)
                          borderRadius: BorderRadius.circular(defaultBorderRadius),
                          image: DecorationImage(
                            image: Image.asset('assets/images/maxwell.png').image,
                            // 로컬 이미지 경로
                            fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: defaultPadding * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Maxwell", style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            highlightColor: Colors.white10,
                            borderRadius: BorderRadius.circular(defaultBorderRadius),
                            onTap: () {
                              // Action
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("Image Button")
                ],
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Column(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Material(
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
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultBorderRadius),
                              //color: Colors.green !DO NOT ADD COLOR TO CONTAINER
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Color Button",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(defaultBorderRadius),
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            // Action
                          },
                          borderRadius: BorderRadius.circular(defaultBorderRadius),
                          //highlightColor: Colors.red,
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultBorderRadius),
                              border: Border.all(color: primaryColor, width: 2),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "White Button",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  border: Border.all(color: primaryColor, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Container",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: dummyData.length,
                        itemBuilder: (ctx, i) {
                          final item = dummyData[i];
                          return Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(defaultBorderRadius),
                              border: Border.all(color: primaryColor, width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item['title'], style: TextStyle(fontSize: 16),),
                                Text(item['data'], style: TextStyle(fontSize: 12),),
                              ],
                            )
                          );
                        },
                      ),
                    ),
                  ),
                  Text("Size-Limited Listview")
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultBorderRadius),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: Scrollbar(
                        controller: _scrollController2,
                        thumbVisibility: true,
                        child: ListView.builder(
                          controller: _scrollController2,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (ctx, i) {
                            return Container(
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(defaultBorderRadius),
                                border: Border.all(color: primaryColor, width: 2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Data ${i + 1}', style: TextStyle(fontSize: 16),),
                                  Text('Information ${i + 1}', style: TextStyle(fontSize: 12),),
                                ],
                              )
                            );
                          },
                        ),
                      ),
                    ),
                    Text("Expanded Listview")
                  ],
                )
              )

            ],
          )
        ),
      ),
    );
  }
}
