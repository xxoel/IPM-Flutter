import 'dart:io';
import 'package:app_movil/edamam.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async'; //For StreamController/Stream


class ConnectionStatusSingleton {

  static final ConnectionStatusSingleton _singleton = ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton getInstance() => _singleton;

  int hasConnection = 0;

  StreamController connectionChangeController =StreamController.broadcast();

  final Connectivity _connectivity =Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  // Because this is meant to exist through the entire application life cycle this isn't
  // really an issue
  void dispose() {
    connectionChangeController.close();
  }
  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }
  //The test to actually see if there is a connection
  Future checkConnection() async {
    int previousConnection = hasConnection;
    try {
      final result =await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try{
          final result = await InternetAddress.lookup('www.edamam.com');
          if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
            hasConnection = 0; //CONNECTION OK
          }
        } on SocketException catch(_) {
          hasConnection = 1; //SERVER
        }
      }
    } on SocketException catch(_) {
      hasConnection = 2; //RED
    }
    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }
}
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
              'assets/pinguino.jpeg',
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
                    //int checkConnection = await _checkConnection();
                   // if (checkConnection == 0) {
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
                children: [isOffline == 1 ? _errorServerConection() : _errorRedConection()]
              ): Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [searchBar,buttonSection]
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )
    )
    );
  }

  Center _errorServerConection(){
    return Center(
        child: Column(
            children: [Image.asset(
                'assets/PinguinoServer.jpeg',
                width: 250,
                height: 250,
                fit: BoxFit.fill),
              const TextField(
                enabled: false,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 22,height: 2.0),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ha ocurrido un error de conexión con el servidor o no'
                        'se ha podido establecer. Espere unos segundos o inténtelo de'
                        ' nuevo más tarde'
                ),
              )
            ]

        )
    );
  }

  Center _errorRedConection(){
    return Center(
        child: Column(
            children: [Image.asset(
                'assets/PinguinoServer.jpeg',
                width: 250,
                height: 250,
                fit: BoxFit.fill),
              const TextField(
                enabled: false,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 22,height: 2.0),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Error de red: No se ha podido establecer la conexión a internet.'
                        ' Compruebe su conexión a la red o inténtelo de nuevo más tarde.'
                ),
              )
            ]
        )
    );
  }
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
    )
    );
  }
}

class VentanaBusqueda extends StatelessWidget {
  final RecipeBlock? block;
  const VentanaBusqueda({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    print(search_recipes(block!.nextBlock!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('VentanaBusqueda'),
      ),
      body: Center(
          child:SingleChildScrollView(
            child:Column(
              children:[
                for(var recipe in block!.recipes!)
                  Ink.image(
                    width: double.infinity,
                    height:240,
                    fit: BoxFit.cover,
                    image: NetworkImage('${recipe.image}'),
                    child: Center(
                        child: Stack(
                                children:
                                [Text("${recipe.label}",
                                   style: TextStyle(
                                   fontSize: 40,
                                   foreground: Paint()
                                     ..style= PaintingStyle.stroke
                                     ..strokeWidth= 6
                                     ..color= Colors.black,
                                 ),),
                                Text("${recipe.label}",
                                    style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                    )),],),
            )),
          ElevatedButton(
          onPressed: () {
            Navigator.pop(context);

          },
          child:const Text('Volver'),
        ),
          const TextField (
            enabled: false,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,fontSize: 22,height: 2.0),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              search_recipes(block!.nextBlock!).then((data){
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) =>  VentanaBusqueda(block: data)));
              });
            },
            child:const Text('Siguiente página'),
          ),
      ],
      ),
      )
    )
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
        child: Expanded(
            child : SingleChildScrollView(
              child : Column(
            children:[const SizedBox(
            height: 200,),
            Image.asset(
              'assets/PinguinoPensativo.jpeg',
              width: 250,
              height: 250,
              fit: BoxFit.fill),
            const SizedBox(
              height: 200,
            ),
            const TextField(
              enabled: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Vaya, su palabra no está relacionada con ninguna receta :('
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:const Text('Volver'),
          ),
        ]
      )
    )),
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


