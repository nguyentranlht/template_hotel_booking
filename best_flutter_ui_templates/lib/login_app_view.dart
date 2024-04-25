import 'package:best_flutter_ui_templates/hotel_booking/hotel_home_screen.dart';
import 'package:best_flutter_ui_templates/navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:best_flutter_ui_templates/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:best_flutter_ui_templates/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:best_flutter_ui_templates/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:best_flutter_ui_templates/auth/welcome_screen.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';

class LoginAppView extends StatelessWidget {
  const LoginAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'best_flutter_ui_templates',
			theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Color.fromARGB(255, 221, 220, 220),
          onBackground: Colors.black,
          primary: Color.fromRGBO(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromRGBO(244, 143, 177, 1),
          onSecondary: Colors.white,
					tertiary: Color.fromRGBO(255, 204, 128, 1),
          error: Colors.red,
					outline: Color(0xFF424242)
        ),
			),
			home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
				builder: (context, state) {
					if(state.status == AuthenticationStatus.authenticated) {
						return MultiBlocProvider(
								providers: [
									BlocProvider(
										create: (context) => SignInBloc(
											userRepository: context.read<AuthenticationBloc>().userRepository
										),
									),
									BlocProvider(
										create: (context) => UpdateUserInfoBloc(
											userRepository: context.read<AuthenticationBloc>().userRepository
										),
									),
									BlocProvider(
										create: (context) => MyUserBloc(
											myUserRepository: context.read<AuthenticationBloc>().userRepository
										)..add(GetMyUser(
											myUserId: context.read<AuthenticationBloc>().state.user!.uid
										)),
									),
								],
							child: NavigationHomeScreen(),
						);
					} else {
						return const WelcomeScreen();
					}
				}
			),
		);
  }
}