import 'package:app_movil/edamam.dart';
import 'package:flutter/material.dart';
import 'ventanaInfoDetallada.dart';
import 'dart:async';
import 'errors.dart';
import 'ventanasHelpOpc.dart';
import  'ventanaBusqErronea.dart';
import 'connectionStatus.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton connectionStatusSingleton = ConnectionStatusSingleton.getInstance();
  connectionStatusSingleton.initialize();
  runApp(const MyApp());
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

  late StreamSubscription connectionChangeStream;
  late Future<RecipeBlock?> receta;

  int isOffline = 0;

  @override
  initState() {
    super.initState();

    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = hasConnection;
    });
  }

  late Future<RecipeBlock?> recetas;
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose(){
    _text.dispose();
    super.dispose();
  }

  Widget makeSearchBar() {
    Widget searchBar = Container(
      margin: const EdgeInsets.only(top: 100, left: 80, right: 80, bottom: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
              'assets/PinguinoChef.png',
              width: 250,
             height: 250,
             fit: BoxFit.fill
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
           child: TextField(
                controller: _text,
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
               ),
                onSubmitted: (value) {
                  setState(()  {
                    _text.text.isEmpty ? _validate = true : _validate = false;
                    if(!_validate){
                        search_recipes(_text.text).then((value) {
                        if (value?.count == 0) {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => const VentanaBusquedaNoEncontrada()));
                        }
                        else {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  VentanaBusqueda(block: value)),);
                        }
                      },
                      );
                  }});

               },
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
              child: isOffline !=0 ? Column(
                children: [isOffline == 1 ?  ErrorServidor() : ErrorRed()]
              ): Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [searchBar,buttonSection]
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )
    )
    );
  }
}

class VentanaBusqueda extends StatelessWidget {

  final RecipeBlock? block;

  const VentanaBusqueda({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    if (block?.recipes != null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('VentanaBusqueda'),
          ),
          body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for(var recipe in block!.recipes!)
                      Ink.image(
                          width: double.infinity,
                          height: 240,
                          fit: BoxFit.cover,
                          image: NetworkImage('${recipe.image}'),
                          child: Center(
                            child: Stack(
                              children:
                              [Text(
                                "${recipe.label}",
                                style: TextStyle(
                                  fontSize: 40,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black,
                                ),),
                                InkWell(
                                  child: Text("${recipe.label}",
                                    style: const TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                    )),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                           ventanaInfo(recipe: recipe)),);
                                  },
                                )
                              ],),
                          )),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Volver'),
                    ),
                    const TextField (
                      enabled: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: 22, height: 2.0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (block?.nextBlock != null) {
                          own_search_recipes(block!.nextBlock!).then((data) {
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(
                                builder: (context) =>
                                    VentanaBusqueda(block: data)),);
                          });
                        }
                      },
                      child: const Text('Siguiente página'),
                    ),
                  ],
                ),
              )
          )
      );
    }
    else {
      return const CircularProgressIndicator();
    }
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



