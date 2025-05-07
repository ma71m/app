import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final Duration duration;
  final TextStyle style;

  const CountdownTimer({super.key, required this.duration, required this.style});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration remainingDuration;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    remainingDuration = widget.duration;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingDuration = remainingDuration - const Duration(seconds: 1);
        if (remainingDuration.isNegative ||
            remainingDuration == Duration.zero) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      int hours = duration.inHours % 24;
      return '${duration.inDays}d ${hours}h';
    } else if (duration.inHours > 0) {
      int minutes = duration.inMinutes % 60;
      return '${duration.inHours}h ${minutes}m';
    } else if (duration.inMinutes > 0) {
      int seconds = duration.inSeconds % 60;
      return '${duration.inMinutes}m ${seconds}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDuration(remainingDuration),
      style: widget.style,
    );
  }
}
