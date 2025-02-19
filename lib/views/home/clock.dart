// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:amsystm/data/models/attendence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // request permissions until the user grants them
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // request permissions until the user grants them
        permission = await Geolocator.requestPermission();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // request permissions until the user grants them
      permission = await Geolocator.requestPermission();
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

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

    return GestureDetector(
      onTap: () async {
        final Position position = await _determinePosition();

        await showDialog(
          context: context,
          builder: (context) {
            return MapDisplay(
              latitude: position.latitude,
              longitude: position.longitude,
            );
          },
        );

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
                    )),
        ),
      ),
    );
  }
}

class MapDisplay extends StatelessWidget {
  const MapDisplay({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

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
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          title: const Text('Your Location'),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.blueAccent, width: 2.0),
            ),
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(latitude, longitude),
                initialZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  maxZoom: 19,
                ),
                LocationMarkerLayer(
                  position: LocationMarkerPosition(
                    latitude: latitude,
                    longitude: longitude,
                    accuracy: 9.0,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final String id = context.read<AuthBloc>().state.user.id ?? '';
                final String time = getTime();
                context
                    .read<UserBloc>()
                    .add(ClockInOutEvent(id: id, time: time));
                Navigator.pop(context);
              },
              child: const Text('Proceed'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
