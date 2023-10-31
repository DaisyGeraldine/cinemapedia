import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slidesShowMovies = ref.watch(moviesSlideshowProvider);

    return Column(
      children: [
        CustomAppbar(),

        MoviesSlideshow(
          movies: slidesShowMovies,
        ),

        MovieHorizontalListview(
          movies: slidesShowMovies,
          title: 'En Cartelera',
          subtitle: 'Peliculas que estan en cartelera',
          loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
        ),

      ],
    );
  }
}