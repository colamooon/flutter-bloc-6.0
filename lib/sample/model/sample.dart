import 'package:json_annotation/json_annotation.dart';

part 'sample.g.dart';

@JsonSerializable()
class Sample {
  Sample(
    this.title,
    this.content,
  );
  final String title;
  final String content;

  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);
  Map<String, dynamic> toJson() => _$SampleToJson(this);
}
