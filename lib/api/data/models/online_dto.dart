import 'package:json_annotation/json_annotation.dart';

part 'online_dto.g.dart';

@JsonSerializable()
class OnlineDto {
  OnlineDto({
    required this.online,
  });

  final int online;

  factory OnlineDto.fromJson(Map<String, dynamic> json) =>
      _$OnlineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineDtoToJson(this);

  Online toDomain() => Online(
        currentOnline: online,
      );
}
