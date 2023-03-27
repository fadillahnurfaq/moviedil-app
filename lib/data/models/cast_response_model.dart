import 'package:ditonton_yuk/data/models/cast_model.dart';
import 'package:equatable/equatable.dart';

class CastResponseModel extends Equatable {
  final List<CastModel> castList;

  const CastResponseModel({required this.castList});

  factory CastResponseModel.fromJson(Map<String, dynamic> json) =>
      CastResponseModel(
        castList: List<CastModel>.from((json["cast"] as List)
            .map((x) => CastModel.fromJson(x))
            .where((element) => element.profilePath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(castList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [castList];
}
