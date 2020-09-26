import 'dart:async';

import 'package:shop_bloc/sample/model/models.dart';
import 'package:shop_bloc/support/dioclient/api_result.dart';
import 'package:shop_bloc/support/dioclient/dio_client.dart';

class SampleGetFailure implements Exception {}

class SampleRepository {
  final DioClient _dioClient;
  SampleRepository(this._dioClient) : assert(_dioClient != null);

  Future<ApiResult<Sample>> getSample() async {
    print(']-----] SampleRepository::getSample [-----[ ');
    try {
      final response = await _dioClient.get("/api/v1/dummy");
      Sample sample = Sample.fromJson(response);
      print(']-----] SampleRepository::getSample.sample [-----[ ${sample}');
      return ApiResult.success(data: sample);
    } on Exception {
      throw SampleGetFailure();
    }
  }
}
