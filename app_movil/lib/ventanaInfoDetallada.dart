import 'package:flutter/material.dart';
import 'edamam.dart';

class ventanaInfo extends StatelessWidget {
  final Recipe recipe;
  const ventanaInfo({super.key,required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black87,
          title: const Text('VentanaINFO'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Text(
                      "${recipe.label}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                      )
                  )
                ]
            )
        )
    );
  }
}