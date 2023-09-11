import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key, required this.message, required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.red,
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
                child: Row(
                  children: [
                    Text(time),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.done_all)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
