
import 'package:ditonton_yuk/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponseModel extends Equatable {
  final List<TvSeriesModel> tvSeriesList;

  const TvSeriesResponseModel({required this.tvSeriesList});

  factory TvSeriesResponseModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponseModel(
        tvSeriesList: List<TvSeriesModel>.from((json['results'] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) =>
                element.posterPath != null && element.overview != '')),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvSeriesList];
}
