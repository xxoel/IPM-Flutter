import 'package:flutter/material.dart';

class ErrorServidor extends StatelessWidget {

  const ErrorServidor({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.orange,
            border: Border(),
          ),
          child: Column(
            children: [
              Image.asset(
                  'assets/Segurata.png',
                  width: 250,
                  height: 250,
                  fit: BoxFit.fill),
              const SizedBox(
                height: 150,
              ),
              const TextField(
                enabled: false,
                minLines: 2,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 22, height: 2.0),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ha ocurrido un error de conexión con el servidor o no'
                        'se ha podido establecer. Espere unos segundos o inténtelo de'
                        ' nuevo más tarde'
                ),
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
        child: Column(
            children: [
              Image.asset(
                  'assets/Segurata.png',
                  width: 250,
                  height: 250,
                  fit: BoxFit.fill),
              const TextField(
                enabled: false,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 22, height: 2.0),
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