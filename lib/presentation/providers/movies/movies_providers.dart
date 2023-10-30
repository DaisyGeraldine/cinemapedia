import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {

    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
    return MoviesNotifier(
      fetchMoreCallback: fetchMoreMovies
    );
  }
);

// Definir el caso de uso
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {


  int currentPage = 0;
  MovieCallback fetchMoreCallback;

  MoviesNotifier({
    required this.fetchMoreCallback,
  }) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final movies = await fetchMoreCallback(page: currentPage);
    state = [...state, ...movies];
    
    
  }

  // Future<void> getNowPlaying({int page = 1}) async {
  //   final movies = await _moviesRepository.getNowPlaying(page: page);
  //   state = [...state, ...movies];
  // }
}