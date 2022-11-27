import 'package:flutter/material.dart';

class ErrorServidor extends StatelessWidget {

  const ErrorServidor({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                      'assets/Segurata.png',
                      width: 250,
                      height: 250,
                      fit: BoxFit.fill),
                  const SizedBox(
                    height: 50,
                  ),
                    Theme(data:ThemeData(disabledColor: Colors.black87),child: const TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 45,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Vaya!'
                    ),
                    style: TextStyle(fontSize: 100),

                  )),
                  const TextField(
                    minLines: 3,
                    maxLines: 45,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontSize: 25, height: 1.0),
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple,
                            width: 5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Ha ocurrido un error de conexión con el servidor o no '
                            'se ha podido establecer. Espere unos segundos o inténtelo de'
                            ' nuevo más tarde'
                    ),
                    enabled: false,
                  )
                ]
            )
        )
    );
  }
}

class ErrorRed extends StatelessWidget {

  const ErrorRed({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                      'assets/Segurata.png',
                      width: 250,
                      height: 250,
                      fit: BoxFit.fill),
                  const SizedBox(
                    height: 50,
                  ),
                   Theme(data:ThemeData(disabledColor: Colors.black87),child: const TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 45,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Vaya!'
                    ),
                    style: TextStyle(fontSize: 100,color:Colors.black87),

                  )),
                  const TextField(
                    minLines: 3,
                    maxLines: 45,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontSize: 25, height: 1.0),
                    decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple,
                            width: 5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Error de red: No se ha podido establecer la conexión a internet.'
                            ' Compruebe su conexión a la red o inténtelo de nuevo más tarde.'
                    ),
                    enabled: false,
                  )
                ]
            )
        )
    );
  }
}