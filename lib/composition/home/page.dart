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
              children: [
                for (int i = 0; i < items.length * 2 - 1; i++)
                  if (i % 2 == 1)
                    const Divider(height: 0.0)
                  else
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/room_detail");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "하루에 만 보 걷기 🚶‍♂️",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    "만 걸음 걸을 때마다 하루씩 젊어져요!",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            color: Colors.grey[600],
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "조대훈",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: " • 참여 인원 ",
                                            ),
                                            TextSpan(
                                              text:
                                                  "${items[i ~/ 2].participantCount}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: "/20명",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  "95%",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8.0)
                          ],
                        ),
                      ),
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
