import 'dart:async';
import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize the time and start the timer
    _currentTime = getTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = getTime();
      });
    });
  }

  // get the current time - hour and minute and second
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

  @override
  void dispose() {
    // Cancel the timer to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        return Container(
          width: 154,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: () {
              // get user id
              final String id = context.read<AuthBloc>().state.user.id ?? '';

              // get the current time
              final String time = getTime();

              // dispatch the clock in/out event
              context.read<UserBloc>().add(ClockInOutEvent(id: id, time: time));
            },
            child: FittedBox(
              child: Column(
                children: [
                  // Display current year , month and day
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
              ),
            ),
          ),
        );
      },
    );
  }
}
