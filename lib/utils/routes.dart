import 'package:amsystm/bloc/auth/auth_bloc.dart';
import 'package:amsystm/navigation_observer.dart';
import 'package:amsystm/observer.dart';
import 'package:amsystm/views/attendence/add_employee.dart';
import 'package:amsystm/views/home/main_page.dart';
import 'package:amsystm/views/leave/add_leave.dart';
import 'package:amsystm/views/reset_password/reset_password.dart';
import 'package:amsystm/views/sign_in/sign_in.dart';
import 'package:amsystm/views/sign_up/register_one.dart';
import 'package:amsystm/views/sign_up/register_two.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppRouter {
  AppRouter({required this.authBloc, required this.observer}) {
    _router = GoRouter(
      observers: [observer],
      routes: [
        ShellRoute(
          builder: (context, state, child) => ObserverPage(child: child),
          routes: [
            GoRoute(
              path: '/login',
              name: 'login',
              builder: (context, state) => const SignInPage(),
              routes: [
                GoRoute(
                  path: 'reset_password',
                  name: 'reset_password',
                  builder: (context, state) => const ResetPasswordPage(),
                ),
                GoRoute(
                  path: 'sign_up',
                  name: 'sign_up',
                  builder: (context, state) => const RegisterOne(),
                  routes: [
                    GoRoute(
                      path: 'register',
                      name: 'register',
                      builder: (context, state) => RegisterTwo(
                        details: state.extra as Map<String, dynamic>,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const MainPage(),
              routes: [
                GoRoute(
                  path: 'add-leave',
                  name: 'add-leave',
                  builder: (context, state) => const AddLeavePage(),
                ),
                GoRoute(
                  path: 'add-employee',
                  name: 'add-employee',
                  builder: (context, state) => const AddEmployee(),
                ),
                // GoRoute(
                //   path: 'message',
                //   name: 'message',
                //   builder: (context, state) => const MessageScreen(),
                // ),
                // GoRoute(
                //   path: 'friend',
                //   name: 'friend',
                //   builder: (context, state) => FriendProfile(
                //     friend: state.extra as User,
                //   ),
                // ),
                // GoRoute(
                //   path: 'updatePost',
                //   name: 'updatePost',
                //   builder: (context, state) => UpdatePostScreen(
                //     model: state.extra as Post,
                //   ),
                // ),
                // GoRoute(
                //   path: 'editProfile',
                //   name: 'editProfile',
                //   builder: (context, state) => UpdateProfileScreen(
                //     model: state.extra as User,
                //   ),
                // ),
              ],
            ),
          ],
        )
      ],
      initialLocation: '/',
      debugLogDiagnostics: true,
      routerNeglect: true,
      redirect: (context, state) {
        final bool isSignInRoute = state.matchedLocation.startsWith('/login');

        final token = HydratedBloc.storage.read('token');

        final isAuthenticated = token != null && token != '';

        if (isSignInRoute && isAuthenticated) {
          return '/';
        } else if (!isSignInRoute && !isAuthenticated) {
          return '/login';
        }

        return null;
      },
    );
  }

  final AuthBloc authBloc;
  final NavigationObserver observer;

  late final GoRouter _router;
  GoRouter get router => _router;
}
