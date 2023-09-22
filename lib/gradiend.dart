import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';

class MyTheme {
  static BoxDecoration teenColor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFFBD6AE7), Color(0xFF6A3CB5)],
      ),
    );
  }

  static BoxDecoration kidsColor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFFBAE969), Color(0xFF5AB438)],
      ),
    );
  }

  static BoxDecoration adultColor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFF60B0F5), Color(0xFF1572C3)],
      ),
    );
  }
}
