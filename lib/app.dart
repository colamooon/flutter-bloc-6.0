import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'authentication/authentication.dart';
import 'home/home.dart';
import 'loading/loading.dart';
import 'locale/locale.dart';
import 'login/login.dart';
import 'repository/repository.dart';
import 'splash/splash.dart';
import 'support/dioclient/dio_client.dart';
import 'support/intl/demoLocalizations.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.loadingCubit,
    @required this.localeCubit,
    @required this.dioClient,
  })  : assert(authenticationRepository != null),
        assert(loadingCubit != null),
        assert(localeCubit != null),
        assert(dioClient != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final LoadingCubit loadingCubit;
  final LocaleCubit localeCubit;
  final DioClient dioClient;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<SampleRepository>(
          create: (context) => SampleRepository(dioClient),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<LoadingCubit>(
            create: (context) => loadingCubit,
          ),
          BlocProvider<LocaleCubit>(
            create: (context) => localeCubit,
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  Locale _locale;
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    super.initState();
    _locale = const Locale('ko', '');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ko', ''),
      ],
      locale: _locale,
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      HomePage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  default:
                    break;
                }
              },
            ),
            BlocListener<LoadingCubit, LoadingState>(
              listener: (context, state) {
                if (state is Loading) {
                  _showLoadingDialog();
                }
                if (state is LoadingInitial) {
                  Navigator.of(_navigator.overlay.context, rootNavigator: true)
                      .pop();
                }
              },
            ),
            BlocListener<LocaleCubit, LocaleState>(
              listener: (context, state) {
                if (state.isChanged) {
                  setState(() {
                    _locale = state.locale;
                  });
                }
              },
            ),
          ],
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }

  Future<void> _showLoadingDialog() async {
    return showDialog<void>(
      context: _navigator.overlay.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoActivityIndicator();
      },
    );
  }
}
