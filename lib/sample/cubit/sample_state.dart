part of 'sample_cubit.dart';

class SampleState extends Equatable {
  const SampleState({
    this.sample,
    this.error,
    this.idLoaded,
  });

  final Sample sample;
  final NetworkExceptions error;
  final bool idLoaded;

  @override
  List<Object> get props => [sample, error, idLoaded];

  SampleState copyWith({
    Sample sample,
    NetworkExceptions error,
    bool idLoaded,
  }) {
    return SampleState(
      sample: sample ?? this.sample,
      error: error ?? this.error,
      idLoaded: idLoaded ?? this.idLoaded,
    );
  }
}
