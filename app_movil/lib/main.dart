import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Edaman Recipe Seeker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _text = TextEditingController();
  bool _validate = false;

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
            'assets/chef.png',
            width: 150,
            height: 150,
            fit: BoxFit.fill
        ),
        Image.asset(
            'assets/edamam.png',
            width: 150,
            height: 150,
            fit: BoxFit.fill
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              controller: _text,
              onChanged: (value) => searchResults(value),
              onSubmitted: (value) {
                setState(() {
                  /*bool conexion = false;
                        try{
                          final result = await InternetAddress.lookup('www.google.com');
                          if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
                            conexion = true;
                          }
                        }
                        on SocketException catch (_){}*/
                  _text.text.isEmpty ? _validate = true : _validate = false;
                  if (!_validate) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const VentanaBusqueda()),);
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
      child: Icon(icon,color: color,size: 80.0),
      onTap: (){
        if(label == "OPT") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const VentanaOpciones()),
          );}
        if(label == "HELP") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const VentanaAyuda()),
          );}
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
                  const TextField(
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
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Volver'),
                )
                ],
            )
      ),
    )
    );
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
            height: 250,
          ),
            Image.asset(
              'assets/pingu.png',
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
        )
      ),
    );
  }
}
