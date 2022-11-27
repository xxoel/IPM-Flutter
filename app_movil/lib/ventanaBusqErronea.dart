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
                        height: 100,),
                        Image.asset(
                            'assets/PinguinoPensativo.png',
                            width: 250,
                            height: 250,
                            fit: BoxFit.fill),
                        const SizedBox(
                          height: 75,
                        ),
                        const TextField(
                          enabled: false,
                          minLines: 1,
                          maxLines: 45,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Vaya, su palabra no está relacionada con ninguna receta :('

                          ),
                          style: TextStyle(fontSize: 40),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height:75,
                          width: 200,
                          child :ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(width:5, color:Colors.deepPurple),
                              padding: const EdgeInsets.all(20),
                            ),
                          child:const Text('Volver',style: TextStyle(fontSize: 35,color: Colors.black,),)
                        ),
                        )
                      ]
                  )
              )),
        )
    );
  }
}