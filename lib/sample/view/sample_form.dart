import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc/loading/loading.dart';
import 'package:shop_bloc/locale/locale.dart';

import '../sample.dart';

class SampleForm extends StatefulWidget {
  @override
  _SampleFormState createState() => _SampleFormState();
}

class _SampleFormState extends State<SampleForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SampleCubit, SampleState>(
      listener: (context, state) {
        if (state.idLoaded) {
          context.bloc<LoadingCubit>().isLoaded();
        }
      },
      child: Column(
        children: [
          Text('Sample'),
          BlocBuilder<SampleCubit, SampleState>(
            builder: (context, state) {
              return Column(
                children: [
                  if (state.sample != null) Text('${state.sample.title}'),
                  RaisedButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    child: const Text('LOGIN'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: const Color(0xFFFFD600),
                    onPressed: () {
                      context.bloc<LoadingCubit>().isLoading();
                      context.bloc<SampleCubit>().getSample();
                    },
                  ),
                  RaisedButton(
                    key: const Key('loginForm_continue_raisedButton1'),
                    child: const Text('TO EN'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: const Color(0xFFFFD600),
                    onPressed: () {
                      context
                          .bloc<LocaleCubit>()
                          .localeChanged(const Locale('en', ''));
                    },
                  ),
                  RaisedButton(
                    key: const Key('loginForm_continue_raisedButton2'),
                    child: const Text('TO KO'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: const Color(0xFFFFD600),
                    onPressed: () {
                      context
                          .bloc<LocaleCubit>()
                          .localeChanged(const Locale('ko', ''));
                    },
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
