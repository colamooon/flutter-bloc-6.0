import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'loading/loading.dart';
import 'locale/locale.dart';
import 'repository/authentication_repository.dart';
import 'simple_bloc_observer.dart';
import 'support/dioclient/dio_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  DioClient dioClient = DioClient(Dio());
  runApp(App(
    authenticationRepository: AuthenticationRepository(dioClient),
    loadingCubit: LoadingCubit(),
    localeCubit: LocaleCubit(),
    dioClient: dioClient,
  ));
}
