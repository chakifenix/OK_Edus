import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.message, required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          // margin: EdgeInsets.only(left: 20),
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 60, bottom: 30),
                child: Text(message),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(time),
              )
            ],
          ),
        ),
      ),
    );
  }
}
