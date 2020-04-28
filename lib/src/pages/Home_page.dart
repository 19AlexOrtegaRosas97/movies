import 'package:flutter/material.dart';

import 'package:movies/src/Widgets/card_swiper_Widget.dart';
import 'package:movies/src/providers/peliculas_providers.dart';

//19AlexOrtega97
class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCard(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCard() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData){
          return CardSwiper(movies: snapshot.data);
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares',style: Theme.of(context).textTheme.subhead,),
          FutureBuilder(
            future: peliculasProvider.getPoupulares(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
