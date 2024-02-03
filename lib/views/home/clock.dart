import 'dart:async';
import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:amsystm/data/models/attendence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  late String _currentTime;
  int _secondsElapsed = 0;
  bool isClockedIn = false;

  String getTime() {
    final DateTime now = DateTime.now();
    int hour = now.hour;
    String period = 'AM';

    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }

    final String formattedHour = hour.toString().padLeft(2, '0');
    final String minute = now.minute.toString().padLeft(2, '0');
    final String second = now.second.toString().padLeft(2, '0');

    return '$formattedHour:$minute:$second $period';
  }

  var newDt = DateFormat.yMMMEd().format(DateTime.now());

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedHour = hours.toString().padLeft(2, '0');
    String formattedMinute = minutes.toString().padLeft(2, '0');
    String formattedSecond = remainingSeconds.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute:$formattedSecond';
  }

  @override
  void initState() {
    super.initState();
    _currentTime = formatTime(_secondsElapsed);
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _secondsElapsed++;
        _currentTime = formatTime(_secondsElapsed);
      });
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _secondsElapsed++;
        _currentTime = formatTime(_secondsElapsed);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Attendence showClock = context.read<UserBloc>().state.attendence;

    final bool isInTimeEmpty =
        showClock.inTime == null || showClock.inTime == '';
    final bool isOutTimeEmpty =
        showClock.outTime == null || showClock.outTime == '';

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return GestureDetector(
          onTap: () {
            final String id = context.read<AuthBloc>().state.user.id ?? '';
            final String time = getTime();
            context.read<UserBloc>().add(ClockInOutEvent(id: id, time: time));

            if (isInTimeEmpty && !isClockedIn) {
              startTimer();
              isClockedIn = true;
            }
          },
          child: Container(
            width: 154,
            height: 52,
            decoration: BoxDecoration(
              color: isInTimeEmpty
                  ? Colors.red
                  : (isOutTimeEmpty ? Colors.blue : Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FittedBox(
                child: isInTimeEmpty
                    ? Column(
                        children: [
                          Text(
                            newDt,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const Text(
                            'Clock In',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : (isOutTimeEmpty
                        ? Column(
                            children: [
                              Text(
                                newDt,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                _currentTime,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                newDt,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const Text(
                                'Clock In',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ))),
          ),
        );
      },
    );
  }
}
