import 'package:flutter/material.dart';
import 'package:ok_edus/model/notification-model.dart';

import '../../main-bar-page/view/chat-screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationList = [
    NotificationModel(title: 'Hello', subTitle: 'Today Monday'),
    NotificationModel(title: 'Hello', subTitle: 'Today Tuesday')
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text('Notification')),
          body: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9, right: 9, top: 10),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8199999928474426),
                      ),
                      child: ListTile(
                        // onTap: () {},
                        title: Text('${notificationList[index].title}'),
                        subtitle: Text('${notificationList[index].subTitle}'),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: AssetImage('images/girl1.png')),
                          ),
                        ),
                        trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(100)),
                              )
                            ]),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
