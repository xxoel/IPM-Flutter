import 'package:flutter/material.dart';

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
                            'assets/PinguinoPensativo.png',
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