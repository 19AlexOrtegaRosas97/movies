import 'package:flutter/material.dart';

import 'package:movies/src/Widgets/card_swiper_Widget.dart';
import 'package:movies/src/Widgets/movie_horizontal.dart';
import 'package:movies/src/providers/peliculas_providers.dart';
import 'package:movies/src/search/search_delegate.dart';

//19AlexOrtega97
class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPoupulares();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en el Cine'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, color: Colors.white), 
              onPressed: () {
                showSearch(
                  context: context, 
                  delegate: DataSearch(),
                  //query: 'Holaa',
                );
              }
          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text('Populares',style: Theme.of(context).textTheme.subhead,),
            padding: EdgeInsets.only(left: 20.0),
          ),
          SizedBox(height: 5.0,),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              //snapshot.data?.forEach((p) => print(p.title));
              if(snapshot.hasData){
                 return MovieHorizontal(
                   peliculas: snapshot.data,
                   siguientePagina: peliculasProvider.getPoupulares,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
