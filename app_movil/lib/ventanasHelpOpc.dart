import 'package:flutter/material.dart';

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
                      child: SingleChildScrollView(child: TextField(
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
        body: SingleChildScrollView(child:DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              border: Border.all(
                        color: Colors.black87,
                        width: 10,),
              gradient: const LinearGradient(
                colors: [Colors.white10,Colors.black26]),
            image: const DecorationImage(image:AssetImage('assets/espaguetis.png'),
                                         fit: BoxFit.cover),
            ),
            child:Expanded(child:Center(
              child:Column(
                children: [const TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
                    style: TextStyle(color:Colors.black87,fontSize: 20),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                       hintText: 'Bienvenido a la pestaña de Opciones'
                    )
                )
                ,const SizedBox(
                  height: 150,
                ),
                Image.asset(
                    'assets/PinguinoAjustes.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.fill),
                const SizedBox(
                  height: 100,
                ),
                SingleChildScrollView(
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [ButtonBar(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            const SizedBox(
                              height: 100,
                            ),
                             ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                ),
                                onPressed: (){},
                                child: const Text(
                                    'Cambiar Tema',
                                    style: TextStyle(color: Colors.white),
                                )),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blue),
                              ),
                              onPressed: (){},
                              child: const Text(
                                  'Cambiar Fuente',
                                  style: TextStyle(color: Colors.white),
                              )),
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
    ))));
  }
}