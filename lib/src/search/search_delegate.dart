import 'package:flutter/material.dart';
import 'package:movies/src/models/pelicula_model.dart';
import 'package:movies/src/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate {

  final peliculasProvider = new PeliculasProvider();
  final peliculas = [
    'Bad Boys for Life',
    'Cars',
    'As Astra',
    'Tyler Rake'
  ];

  final peliculasRecientes = [
    'Sonic, la pelicula',
    'Home Sweet Home',
  ];

  String seleccion = '';



  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = ''; 
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ), 
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Instruccion que crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias que aparecen cuando a persoa escribe

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

        final peliculas = snapshot.data;

        if(snapshot.hasData){
            return ListView(
              children: peliculas.map((pelicula){
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'), 
                    image: NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    close(context,null);
                    pelicula.cardID = '';
                    Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                  },
                );
              }).toList(),
            );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


  /*  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias que aparecen cuando a persoa escribe

    final listaSugerida = (query.isEmpty) 
                          ? peliculasRecientes
                          : peliculas.where( (p) => p.toLowerCase().startsWith(query.toLowerCase())
                          ).toList(); 


    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
     },
    );
  }*/
}