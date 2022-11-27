import 'package:flutter/material.dart';
import 'edamam.dart';

class VentanaInfo extends StatelessWidget {
  final Recipe recipe;
  const VentanaInfo({super.key,required this.recipe});

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
                    color: Colors.white10,
                    child: Ink.image(
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                        height: 180,
                        image: NetworkImage('${recipe.image}')
                    ),
                  ),
                  Container(
                    color: Colors.amber[800],
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
                    color: Colors.amber[700],
                    child: Text(
                      "CAUTIONS ${recipe.cautions}\n",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.amber[600],
                    child: Text(
                      "INGREDIENTS: ${recipe.ingredients}\n"
                      "CALORIES: ${recipe.calories}\n",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                      color: Colors.amber[500],
                      border: Border.all(color: Colors.blueGrey)
                    ),
                      child: Text(
                          "HEALTH LABELS: ${recipe.dietLabels}\n"
                          "DIET LABELS: ${recipe.healthLabels}",
                          style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                        )
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber[400],
                      border: Border.all(color: Colors.blueGrey)
                    ),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(text: 'TOTAL NUTRIENTS:',style: const TextStyle(color: Colors.black87,fontSize:
                        26,fontWeight: FontWeight.bold),
                        children: <TextSpan>[TextSpan(text: '\n${recipe.totalNutrients}\n',style: const TextStyle(color: Colors.black87,fontSize:
                                            22,fontWeight: FontWeight.normal)),
                                            const TextSpan(text: 'TOTAL DAILY:',style: TextStyle(color: Colors.black87,fontSize:
                                            26,fontWeight: FontWeight.bold)),
                                            TextSpan(text: '\n${recipe.totalDaily}\n',style: const TextStyle(color: Colors.black87,fontSize:
                                            22,fontWeight: FontWeight.normal))]),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber[300],
                      border: Border.all(color: Colors.blueGrey)
                    ),
                      child: Text(
                        "Glycemic Index: ${recipe.glycemicIndex}\n"
                        "Total CO2 Emissions: ${recipe.totalCO2Emissions}\n"
                        "CO2 Emissions Class: ${recipe.co2EmissionsClass}\n",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber[200],
                      border: Border.all(color: Colors.blueGrey)
                    ),
                    child: Text(
                      "CUISINE TYPE: ${recipe.cuisineType}\n"
                      "MEAL TYPE: ${recipe.mealType}\n"
                      "DISH TYPE: ${recipe.dishType}\n",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Volver"
                    ),
                  )
                ]
            )
        )
    );
  }
}