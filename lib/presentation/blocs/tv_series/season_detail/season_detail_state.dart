part of 'season_detail_bloc.dart';

abstract class SeasonDetailState extends Equatable {
  const SeasonDetailState();

  @override
  List<Object?> get props => [];
}

class SeasonDetailEmptyState extends SeasonDetailState {}

class SeasonDetailLoadingState extends SeasonDetailState {}

class SeasonDetailHasDataState extends SeasonDetailState {
  final SeasonDetailEntity result;

  const SeasonDetailHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class SeasonDetailErrorState extends SeasonDetailState {
  final String message;

  const SeasonDetailErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
