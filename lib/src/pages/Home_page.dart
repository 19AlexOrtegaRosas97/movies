import 'package:flutter/material.dart';

import 'package:movies/src/Widgets/card_swiper_Widget.dart';
import 'package:movies/src/providers/peliculas_providers.dart';
//19AlexOrtega97
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en el Cine'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCard(),
          ],
        ),
      ),
    );
  }

  Widget _swiperCard() {
    
    final peliculasProvider = new PeliculasProvider();
    peliculasProvider.getEnCines();

    return CardSwiper(
      movies: [1,2,3,4,5],
    );
  }
}
