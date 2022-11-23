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
            child: ListView(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 200,
                    color: Colors.white,
                    child: Ink.image(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 180,
                        image: NetworkImage('${recipe.image}')
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: Center(child:Text(
                      "${recipe.label}, (SERVINGS: ${recipe.servings})",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      )
                  )
                  ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber[500],
                      border: Border.all(color: Colors.blueGrey)
                    ),
                    height: 100,
                    child: SingleChildScrollView(
                      child: Text(
                          "HEALTH LABELS: ${recipe.dietLabels}\n"
                          "DIET LABELS: ${recipe.healthLabels}",
                          style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                        )
                    ),
                  )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber[400],
                      border: Border.all(color: Colors.blueGrey)
                    ),
                    height: 120,
                    child: SingleChildScrollView(
                      child: Text(
                        "INGREDIENTS: ${recipe.ingredients}\n"
                        "CAUTIONS: ${recipe.cautions}\n",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                      ),
                    ),
                  )
                  )
                ]
            )
        )
    );
  }
}