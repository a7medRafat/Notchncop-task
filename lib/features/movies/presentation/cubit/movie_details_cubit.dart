import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/movies/domain/usecases/get_movie_details.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetails _getMovieDetails;

  MovieDetailsCubit(this._getMovieDetails) : super(MovieDetailsState.initial());

  Future<void> load(int movieId) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _getMovieDetails(movieId: movieId);

    result.when(
      success: (details) {
        emit(state.copyWith(isLoading: false, details: details, error: null));
      },
      failure: (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
    );
  }
}
