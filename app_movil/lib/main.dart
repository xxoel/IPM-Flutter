import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:app_movil/edamam.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
Future<RecipeBlock?> fetchRecipe(query) async {
  final response = await get(Uri.parse(API_URL));
  if (response.statusCode == 200) {
    return search_recipes(query);
  }
  else {
    throw Exception("NOOO");
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Edaman Recipe Seeker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<RecipeBlock?> recetas;
  final _text = TextEditingController();
  double _brightness = 1.0;
  bool _validate = false;

  @override
  void initState(){
    super.initState();
    recetas = fetchRecipe("rice");
  }
  @override
  void dispose(){
    _text.dispose();
    super.dispose();
  }

  final _items = List<String>.generate(100, (i) => "Søgetekst $i");
  List<String> _itemsSuggestions = [];

  void searchResults(String query) {
    setState(() {
      _itemsSuggestions = _items
          .where((data) => data.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  Widget makeSearchBar() {
    Widget searchBar = Container(
      margin: const EdgeInsets.only(top: 100, left: 80, right: 80, bottom: 100),
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
              'assets/pinguino.jpeg',
              width: 250,
             height: 250,
             fit: BoxFit.fill
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
           child: TextField(
                controller: _text,
                onChanged: (value) => searchResults(value),
                onSubmitted: (value) {
                  setState(()  {
                    _text.text.isEmpty ? _validate = true : _validate = false;
                   if (!_validate) {
                     Future<RecipeBlock?> listaRecetas=  search_recipes(_text.text).then((value) {
                       if (value?.count == 0){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => const VentanaBusquedaNoEncontrada()));
                       }
                       else {
                         Navigator.push(context, MaterialPageRoute(
                             builder: (context) => const VentanaBusqueda()),);
                       }
                     },
                     );
                    }
                   _itemsSuggestions = [];
                  });
               },
                decoration: InputDecoration(
                    isDense: true,
                    errorText: _validate ? 'EL CAMPO NO PUEDE ESTAR VACIO' : null,
                    labelText: "Introduzca los datos",
                    hintText: "Recetas",
                    prefixIcon: IconButton(
                     icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                     },
                    ),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _text.clear();
                         setState(() {});
                        }),
                   border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                       )
                   )
               )
            ),
         )
        ],
     ),
    );
    return searchBar;
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    Widget searchBar = makeSearchBar();
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.help, 'HELP',context),
        _buildButtonColumn(color, Icons.settings, 'OPT',context),
      ],
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child:Expanded(
            child: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [searchBar,buttonSection]
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )
    )
    );
  }
}

  Column _buildButtonColumn(Color color, IconData icon, String label,BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: Icon(icon, color: color, size: 80.0),
          onTap: () {
            if (label == "OPT") {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const VentanaOpciones()),
              );
            }
            if (label == "HELP") {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const VentanaAyuda()),
              );
            }
          },
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

class VentanaAyuda extends StatelessWidget {
  const VentanaAyuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VentanaAyuda'),
      ),
      body: Center(
        child:
            Container(
              color: Colors.white,
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 300,
                ),
                  const Expanded(
                    child: TextField(
                    enabled: false,
                    maxLines: 6,
                    minLines: 6,
                    style: TextStyle(color:Colors.white,fontSize: 22,height: 2.0),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'En esta pestaña se mostrará como usar la aplicación de búsqueda de recetas.'
                            'Deberás introducir la palabra clave sobre la cual deseas obtener recetas que la contengan '
                            'en la barra de búsqueda, y una vez hecho esto, presionar la tecla ENTER. '
                            'El sistema se encargará de mostrarte las recetas que contienen esa palabra clave, o el error '
                            'correspondiente. !Muchas gracias por usar nuestra aplicación!'
                    ),
                  )
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Volver'),
                )
                ],
              ))
      ),
    )
    ;
  }
}
class VentanaOpciones extends StatelessWidget {
  const VentanaOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black87,
        title: const Text('VentanaOpciones'),
      ),
      body: Center(
        child:Column(
          children: [const TextField(
            textAlign: TextAlign.center,
            enabled: false,
          style: TextStyle(color:Colors.white,fontSize: 22,height: 2.0),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Bienvenido a la pestaña de Opciones'
          )
          )
            ,const SizedBox(
            height: 150,
          ),
            Image.asset(
              'assets/pinguinoAjustes.jpeg',
              width: 250,
              height: 250,
              fit: BoxFit.fill),
            Expanded(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    const SizedBox(
                      height: 200,
                    ),
                    const ElevatedButton(
                        onPressed: null,
                        child: Text(
                            'Cambiar Tema'
                        )),
                     const ElevatedButton(
                      onPressed: null,
                      child: Text(
                          'Cambiar Fuente'
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Volver'),
                    )
                  ],
                ),
              ]))],
        )
    ));
  }
}
class VentanaBusqueda extends StatelessWidget {
  const VentanaBusqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VentanaBusqueda'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:const Text('Volver'),
        ),
      ),
    );
  }
}
class VentanaBusquedaNoEncontrada extends StatelessWidget {
  const VentanaBusquedaNoEncontrada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VentanaBusqueda F'),
      ),
      body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:const Text('Volver'),
          ),
        /*Image.asset(
            'assets/pinguinothe.jpeg',
            width: 250,
            height: 250,
            fit: BoxFit.fill),
          )
         */

      ),
    );
  }
}
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
class ServicioHttp {

  Future<List<Post>> getPosts() async {
    Response response = await get(Uri.parse(API_URL));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      search_recipes("rice");

      List<Post> posts = body.map((dynamic item) => Post.fromJson(item),)
          .toList();

      return posts;
    }
    else {
      throw "Unable";
    }
  }
}
Future<int> _checkConnection() async{
  try{
    final result = await InternetAddress.lookup('www.edamam.com');
    if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return 0;
    }
  } on SocketException catch (_) {
    try{
      final result = await InternetAddress.lookup('www.google.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        return 1;
      }
    } on SocketException catch (_) {
      return 2;
    }
  }
  return 0;
}

