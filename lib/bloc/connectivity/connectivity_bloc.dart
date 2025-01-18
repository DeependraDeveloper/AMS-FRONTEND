import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc({
    required this.connectivity,
    required this.dio,
  }) : super(const ConnectivityState()) {
    /// Dio options --> setting timeouts for requests
    dio.options.sendTimeout = const Duration(seconds: 4);
    dio.options.receiveTimeout = const Duration(seconds: 4);
    dio.options.connectTimeout = const Duration(seconds: 4);

    /// Event handlers
    on<ConnectivityChecker>(_onConnectivityCheck);
    on<InternetChecker>(_onInternetCheck);
    on<ConnectivitySetter>(_onConnectivitySet);

    /// Periodic check
    // Timer.periodic(const Duration(seconds: 8), (timer) async {
    //   final result = await connectivity.checkConnectivity();
    //   add(InternetChecker(connectivityType: result));
    // });

    /// Connectivity subscription
    subscription = connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) async {
        if (result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile)) {
          add(
            ConnectivitySetter(
              status: ConnectivityStatus.connected,
              connectivityTypes: result,
            ),
          );
        } else {
          add(
            ConnectivitySetter(
              status: ConnectivityStatus.disconnected,
              connectivityTypes: result,
            ),
          );
        }
      },
    );
  }

  StreamSubscription? subscription;
  final Connectivity connectivity;
  final Dio dio;

  FutureOr<void> _onConnectivitySet(event, emit) {
    emit(state.copyWith(
      status: event.status,
      busy: event.busy,
      error: event.error,
      message: event.message,
    ));
  }

  FutureOr<void> _onConnectivityCheck(
      ConnectivityChecker event, Emitter<ConnectivityState> emit) async {
    final result = await connectivity.checkConnectivity();
    emit(state.copyWith(connectivityTypes: result));
    add(InternetChecker(connectivityTypes: result));
  }

  FutureOr<void> _onInternetCheck(
    InternetChecker event,
    Emitter<ConnectivityState> emit,
  ) async {
    try {
      final index = Random().nextInt(3);
      final response = await dio.get(ips[index]);
      if (response.statusCode == 200) {
        emit(
          state.copyWith(
            status: ConnectivityStatus.connected,
            connectivityTypes: event.connectivityTypes,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ConnectivityStatus.disconnected,
            connectivityTypes: event.connectivityTypes,
          ),
        );
      }
    } on DioException catch (_) {
      // print('\x1B[31mError: $_\x1B[0m');
      emit(
        state.copyWith(
          status: ConnectivityStatus.disconnected,
          connectivityTypes: event.connectivityTypes,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ConnectivityStatus.disconnected,
          connectivityTypes: event.connectivityTypes,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}

/*
  /// |:---------------|:-----------|:------------------------------------------------|
  /// | 1.1.1.1        | CloudFlare | https://1.1.1.1                                 |
  /// | 1.0.0.1        | CloudFlare | https://1.1.1.1                                 |
  /// | 8.8.8.8        | Google     | https://developers.google.com/speed/public-dns/ |
  /// | 8.8.4.4        | Google     | https://developers.google.com/speed/public-dns/ |
*/

const ips = [
  'https://1.1.1.1',
  'https://1.0.0.1',
  'https://8.8.8.8',
  'https://8.8.4.4',
];
