import 'package:amsystm/bloc/connectivity/connectivity_bloc.dart';
import 'package:amsystm/views/no_internet/no_internet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObserverPage extends StatefulWidget {
  const ObserverPage({super.key, required this.child});
  final Widget child;

  @override
  State<ObserverPage> createState() => _ObserverPageState();
}

class _ObserverPageState extends State<ObserverPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // context.read<LocationBloc>().add(
      //       LocationPermissionEvent(),
      //     );
      context.read<ConnectivityBloc>().add(
            const ConnectivityChecker(),
          );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      buildWhen: (previous, current) =>
          previous.status.name != current.status.name ||
          previous.connectivityTypes != current.connectivityTypes,
      builder: (context, state) {
        final types = state.connectivityTypes;
        final connected = types.contains(ConnectivityResult.mobile) ||
            types.contains(ConnectivityResult.wifi) ||
            types.contains(ConnectivityResult.ethernet) ||
            types.contains(ConnectivityResult.vpn) ||
            types.contains(ConnectivityResult.other);
        if (!connected && state.status == ConnectivityStatus.disconnected) {
          return const NoInternetPage();
        }
        return widget.child;
      },
    );
  }
}
