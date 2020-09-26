import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial());

  Future<void> isLoading() async {
    emit(Loading());
  }

  Future<void> isLoaded() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => emit(LoadingInitial()),
    );
  }
}
