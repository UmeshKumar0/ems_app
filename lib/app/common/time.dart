import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUpdate extends StatefulWidget {
  TimeUpdate({super.key, required this.showTime, required this.timeStamp});
  bool showTime;
  int timeStamp;
  @override
  State<TimeUpdate> createState() => _TimeUpdateState();
}

class _TimeUpdateState extends State<TimeUpdate> {
  String currentHrs = '00:00:00';
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.showTime) {
      updateTime();
    } else {
      currentHrs = '__:__:__';
    }
  }

  void updateTime() {
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    var checkInTime = DateFormat('HH:mm:ss').format(
      DateTime.fromMillisecondsSinceEpoch(
        widget.timeStamp,
      ),
    );
    var checkIn =
        dateFormat.parse(checkInTime.split(' ').last.split('.').first);
    var now = DateTime.now();
    now = dateFormat.parse(now.toString().split(' ').last.split('.').first);
    currentHrs = now.difference(checkIn).abs().toString().split('.').first;
    setState(() {});
    if(timer != null && timer!.isActive) {
      timer!.cancel();
    }
    timer = Timer(const Duration(seconds: 1), () {
      updateTime();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentHrs,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
