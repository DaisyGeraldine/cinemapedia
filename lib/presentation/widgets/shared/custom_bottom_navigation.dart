import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          label: 'Inicio',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Categorias',
          icon: Icon(Icons.category),
        ),
        BottomNavigationBarItem(
          label: 'Favoritos',
          icon: Icon(Icons.favorite),
        ),
        // BottomNavigationBarItem(
        //   label: 'Peliculas',
        //   icon: Icon(Icons.movie),
        // ),
        // BottomNavigationBarItem(
        //   label: 'Series',
        //   icon: Icon(Icons.tv),
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.movie),
        //   label: 'Movies',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.tv),
        //   label: 'TV Shows',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: 'Search',
        // ),
      ],
    );
  }
}