import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage
  });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent) {
        
        print('Cargar siguientes peliculas');
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if (widget.title != null || widget.subtitle != null)
            _Title(
              title: widget.title,
              subtitle: widget.subtitle,
            ),
          
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, int index) {
                  
                  final movie = widget.movies[index];
  
                  return _Slide(
                    movie: movie,
                  );
              }
            ),
          ),
            

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;
  const _Slide({
    super.key,
    required this.movie  
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,),
      child: Column(
        children: [

          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return FadeIn(
                    child: child,
                  );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                
                },
              ),
              ),
            ),

          const SizedBox(height: 5,),

          //* Title
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textStyles.titleSmall,
          ),

          //* Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star_half_outlined, size: 15, color: Colors.yellow.shade800),
              const SizedBox(width: 5,),
              Text(
                '${movie.voteAverage}',
                style: textStyles.bodyMedium!.copyWith(
                  color: Colors.yellow.shade800,
                )
              ),
              SizedBox(width: 10,),

              //Text('(${movie.popularity})', style: textStyles.bodyMedium,),
              Text(HumanFormats.number(movie.popularity), style: textStyles.bodyMedium,),
              
            ],
          ),

        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;

  const _Title({
    super.key,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (title != null)
            Text(
              title!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          Spacer(),

          if (subtitle != null)
            FilledButton.tonal(
              onPressed: () {},
              child: Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54
                ),
              ),
            ),

        ],
      ),
    );
  }
}