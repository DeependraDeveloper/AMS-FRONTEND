import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/bloc/connectivity/connectivity_bloc.dart';
import 'package:amsystm/bloc/user/user_bloc.dart';
import 'package:amsystm/data/repositories/user.dart';
import 'package:amsystm/data/services/user.dart';
import 'package:amsystm/navigation_observer.dart';
import 'package:amsystm/utils/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (context) => AuthBloc(
            repository: UserRepositoryImpl(
              userService: UserService(
                dio: Dio(),
              ),
            ),
          ),
        ),
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(
            connectivity: Connectivity(),
            dio: Dio(),
          ),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            repository: UserRepositoryImpl(
              userService: UserService(
                dio: Dio(),
              ),
            ),
          )
            ..add(
              GetAttendanceEvent(
                id: BlocProvider.of<AuthBloc>(context).state.user.id ?? '',
              ),
            )
            ..add(
              GetLeavesEvent(
                id: BlocProvider.of<AuthBloc>(context).state.user.id ?? '',
              ),
            )
            ..add(
              GetAllAttendencesEvent(
                id: BlocProvider.of<AuthBloc>(context).state.user.id ?? '',
              ),
            )
            ..add(
              GetAllEmployeesEvent(
                organization: BlocProvider.of<AuthBloc>(context)
                        .state
                        .user
                        .organization ??
                    '',
              ),
            ),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) {
          return previous.user != current.user ||
              previous.user.id != current.user.id ||
              previous.user.token != current.user.token;
        },
        builder: (context, state) {
          return MaterialApp.router(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter(
              authBloc: context.read<AuthBloc>(),
              observer: NavigationObserver(),
            ).router,
          );
        },
      ),
    );
  }
}
