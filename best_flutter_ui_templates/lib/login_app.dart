import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:best_flutter_ui_templates/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'login_app_view.dart';

class LoginApp extends StatelessWidget {
	final UserRepository userRepository;
  const LoginApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
			providers: [
				RepositoryProvider<AuthenticationBloc>(
					create: (_) => AuthenticationBloc(
						myUserRepository: userRepository
					)
				)
			], 
			child: const LoginAppView()
		);
  }
}