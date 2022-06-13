import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    Divider(
                      height: 0.0,
                      color: Colors.grey[200],
                      thickness: 0.5,
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[i ~/ 2].title,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "루틴 방에 대한 간단한 설명 문구 입니다.",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(
                                Icons.people_alt_outlined,
                                color: Colors.grey[600],
                                size: 18.0,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                "${items[i ~/ 2].participantCount}",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          )
                        ],
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
