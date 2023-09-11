import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/api-call.dart';
import 'package:ok_edus/features/schedule-page/view/api-call.dart';

class SchedulePageScreen extends StatelessWidget {
  const SchedulePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: BackButton(color: Colors.black),
          backgroundColor: Colors.blue,
          elevation: 0,
          title: Text(
            'Сабақ кесте',
            style: TextStyle(
              color: Color(0xFF1F2024),
              fontSize: 20,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: ApiCall());
  }
}
