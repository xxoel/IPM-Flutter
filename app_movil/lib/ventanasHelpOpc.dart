import 'package:flutter/material.dart';

class VentanaAyuda extends StatelessWidget {
  const VentanaAyuda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VentanaAyuda'),
      ),
      body:Center(
          child:
          Container(
              color: Colors.white30,
              child:
              SingleChildScrollView(child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Theme(data:ThemeData(disabledColor: Colors.black87),child: const TextField(
                        enabled: false,
                        maxLines: 40,
                        minLines: 1,
                        style: TextStyle(color:Colors.white,fontSize: 22,height: 2.0),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'En esta pestaña se mostrará como usar la aplicación de búsqueda de recetas.'
                                'Deberás introducir la palabra clave sobre la cual deseas obtener recetas que la contengan '
                                'en la barra de búsqueda, y una vez hecho esto, presionar la tecla ENTER. '
                                'El sistema se encargará de mostrarte las recetas que contienen esa palabra clave, o el error '
                                'correspondiente. !Muchas gracias por usar nuestra aplicación!'
                        ),
                  )),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Volver'),
                  )
                ],
              ))
      ),
    ))
    ;
  }
}

class VentanaOpciones extends StatelessWidget {
  const VentanaOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor: Colors.black87,
          title: const Text('VentanaOpciones'),
        ),
        body: DecoratedBox(
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
              child:Center(child:SingleChildScrollView(child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [Theme(data: ThemeData(disabledColor: Colors.black),child: const TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
                    style: TextStyle(color:Colors.red,fontSize: 33),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                       hintText: 'Bienvenido a la pestaña de Opciones'
                    )
                ))
                ,const SizedBox(
                  height: 100,
                ),
                Image.asset(
                    'assets/PinguinoAjustes.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.fill),
                const SizedBox(
                  height: 50,
                ),
                Row(
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
                        ]),],
            )
        )
    )));
  }
}