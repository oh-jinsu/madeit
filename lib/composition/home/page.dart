import 'package:flutter/material.dart';
import 'package:madeit/application/models/list_of.dart';
import 'package:madeit/application/models/room.dart';
import 'package:madeit/application/reducers/list_of_room.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: listOfRoomStore,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as ListOf<RoomModel>;

            final items = data.items;

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                for (int i = 0; i < items.length * 2 - 1; i++)
                  if (i % 2 == 1)
                    const Divider(height: 32.0)
                  else
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "하루에 만 보 걷기",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "만 걸음 걸을 때마다 하루씩 젊어져요!",
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: items[i ~/ 2]
                                          .participantCount
                                          .toString(),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: "명이 함께하고 있어요 🔥",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "평균 성공률",
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "95%",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8.0)
                      ],
                    )
              ],
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[200]!,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          currentIndex: 1,
          selectedFontSize: 12.0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "검색"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "루틴"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "정보"),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("메이드잇"),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[200]!,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
