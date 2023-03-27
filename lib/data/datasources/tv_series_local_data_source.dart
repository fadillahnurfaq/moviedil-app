import '../../utils/exception.dart';
import '../models/tv_series_table_model.dart';
import 'db/database_helper.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlist(TvSeriesTableModel tvSeries);
  Future<String> removeWatchlist(TvSeriesTableModel tvSeries);
  Future<TvSeriesTableModel?> getWatchlistById(int id);
  Future<List<TvSeriesTableModel>> getWatchlist();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvSeriesTableModel tvSeries) async {
    try {
      await databaseHelper.insertWatchlistTvSeries(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTableModel tvSeries) async {
    try {
      await databaseHelper.removeWatchlistTvSeries(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTableModel?> getWatchlistById(int id) async {
    final result = await databaseHelper.getWatchlistTvSeriesById(id);
    if (result != null) {
      return TvSeriesTableModel.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTableModel>> getWatchlist() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTableModel.fromMap(data)).toList();
  }
}
