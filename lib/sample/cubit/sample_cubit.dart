import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_bloc/repository/repository.dart';
import 'package:shop_bloc/sample/model/models.dart';
import 'package:shop_bloc/support/dioclient/api_result.dart';
import 'package:shop_bloc/support/dioclient/network_exceptions.dart';

part 'sample_state.dart';

class SampleCubit extends Cubit<SampleState> {
  SampleCubit(this._sampleRepository)
      : assert(_sampleRepository != null),
        super(const SampleState());

  final SampleRepository _sampleRepository;
  Future<void> getSample() async {
    ApiResult<Sample> apiResult = await _sampleRepository.getSample();
    apiResult.when(success: (Sample data) {
      emit(state.copyWith(sample: data, idLoaded: true));
    }, failure: (NetworkExceptions error) {
      emit(state.copyWith(error: error));
    });
  }
}
