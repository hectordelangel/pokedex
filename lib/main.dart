import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MyApp());
}

Future<Pokemon> fetchPokemon(pokemon) async {
  final response =
      await http.get('https://pokeapi.co/api/v2/pokemon/' + pokemon);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Pokemon.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Pokemon {
  final List<dynamic> forms;
  final List<dynamic> types;
  final List<dynamic> stats;
  final Map<String, dynamic> sprites;
  final int id;

  Pokemon({this.forms, this.types, this.stats, this.sprites, this.id});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        forms: json['forms'],
        types: json['types'],
        sprites: json['sprites'],
        id: json["id"],
        stats: json["stats"]);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pokedex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<Pokemon> futurePokemon;
  final _pokemonName = TextEditingController();

  @override
  void initState() {
    super.initState();
    futurePokemon = fetchPokemon("1");
  }

  void _searchPokemon() {
    setState(() {
      futurePokemon = fetchPokemon(_pokemonName.text.toLowerCase());
    });
  }

  String capitalize(word) {
    return "${word[0].toUpperCase()}${word.substring(1)}";
  }

  Color getBaseStatColor(stat) {
    switch (stat) {
      case "hp":
        return Colors.green;
      case "attack":
        return Colors.red;
      case "defense":
        return Colors.blue;
      case "special-attack":
        return Colors.deepOrange;
      case "special-defense":
        return Colors.deepPurple;
      case "speed":
        return Colors.amberAccent;
    }
  }

  Color getColor(type) {
    switch (type) {
      case "grass":
        return Color(0x00FA9A).withOpacity(0.5);
      case "electric":
        return Color(0xFFDC00).withOpacity(0.5);
      case "poison":
        return Color(0x8300FF).withOpacity(0.5);
      case "normal":
        return Color(0x797979).withOpacity(0.5);
      case "poison":
        return Color(0x8300FF).withOpacity(0.5);
      case "psychic":
        return Color(0xFF00CD).withOpacity(0.5);
      case "ground":
        return Color(0xAE4700).withOpacity(0.5);
      case "ice":
        return Color(0x8BEAFF).withOpacity(0.5);
      case "rock":
        return Color(0xDE5604).withOpacity(0.5);
      case "dragon":
        return Color(0x8855FF).withOpacity(0.5);
      case "water":
        return Color(0x0083FF).withOpacity(0.5);
      case "bug":
        return Color(0xB5F53D).withOpacity(0.5);
      case "dark":
        return Color(0x33362E).withOpacity(0.5);
      case "fairy":
        return Color(0xFF6CFB).withOpacity(0.5);
      case "fire":
        return Color(0xff0000).withOpacity(0.5);
      case "fighting":
        return Color(0xFF5736).withOpacity(0.5);
      case "ghost":
        return Color(0x6400FF).withOpacity(0.5);
      case "steel":
        return Color(0x8D8D8D).withOpacity(0.5);
      case "flying":
        return Color(0x6196FF).withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Pokemon>(
          future: futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/pokedex.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 15,
                                borderOnForeground: true,
                                shadowColor: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: TextField(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                              controller: _pokemonName,
                                              decoration: InputDecoration(
                                                  labelText: "Nombre o número",
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Image.asset(
                                                      'images/pokebola.png',
                                                      width: 20,
                                                      height: 20,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 10,
                                                          left: 10,
                                                          right: 10,
                                                          bottom: 10))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                            capitalize(
                                                snapshot.data.forms[0]["name"]),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40,
                                                color: Colors.white)),
                                      )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Text(
                                            capitalize("#" +
                                                snapshot.data.id.toString()),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.white)),
                                      ),
                                    )
                                  ],
                                )),
                                Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20, top: 5),
                                    child: Row(
                                      children: [
                                        for (var type in snapshot.data.types)
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: getColor(
                                                  "${type["type"]["name"]}"),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                  capitalize(
                                                      "${type["type"]["name"]}"),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.white)),
                                            ),
                                          )
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: new EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .48,
                        right: 20.0,
                        left: 20.0),
                    child: new Container(
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      child: new Card(
                          color: Colors.white,
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:20),
                                      child: Text(
                                        "Base Stats",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    for (var stat in snapshot.data.stats)
                                      Container(
                                          margin: EdgeInsets.only(top: 13),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(stat["stat"]["name"].toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.bold,
                                                              fontSize: 10,
                                                              color: Colors.black)
                                                      ),
                                                )),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Text(stat["base_stat"].toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors.black)
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child:LinearPercentIndicator(
                                                  width: MediaQuery.of(context).size.width - 220,
                                                  animation: true,
                                                  lineHeight: 8.0,
                                                  animationDuration: 2500,
                                                  percent:(stat["base_stat"].toDouble()*1)/200,
                                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                                  progressColor: getBaseStatColor(stat["stat"]["name"].toString()),
                                                ),
                                              )
                                            ],
                                          )),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                  Center(
                      child: Container(
                    alignment: Alignment.topCenter,
                    padding: new EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .28,
                        right: 20.0,
                        left: 20.0),
                    child: new Container(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(snapshot.data.sprites["other"]
                          ["official-artwork"]["front_default"]),
                    ),
                  )),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _searchPokemon,
        tooltip: 'New Game',
        child: Icon(Icons.search),
      ),
    );
  }
}
