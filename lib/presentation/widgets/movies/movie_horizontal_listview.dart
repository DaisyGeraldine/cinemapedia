import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {

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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if (title != null || subtitle != null)
            _Title(
              title: title,
              subtitle: subtitle,
            ),
          
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, int index) {
                  
                  final movie = movies[index];
  
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