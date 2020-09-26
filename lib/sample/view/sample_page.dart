import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc/repository/repository.dart';
import 'package:shop_bloc/support/intl/demoLocalizations.dart';

import '../sample.dart';

class SamplePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SamplePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DemoLocalizations.of(context).title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
            create: (_) => SampleCubit(
                  context.repository<SampleRepository>(),
                ),
            child: SampleForm()),
      ),
    );
  }
}
