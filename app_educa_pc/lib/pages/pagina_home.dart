import 'package:flutter/material.dart';

class fragmentoOne extends StatefulWidget {
  @override
  _fragmentoOneState createState() => _fragmentoOneState();
}

class _fragmentoOneState extends State<fragmentoOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar',
        child: Icon(Icons.add),
        onPressed: null,
      ),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //texto 1
            Container(
              margin: const EdgeInsets.all(30.0),
              padding: const EdgeInsets.all(10.0),
              decoration: myBoxDecoration(), //       <--- BoxDecoration here
              child: Text('Olá! Vamos aprender de forma prática que  a computação faz parte do cotidiano social e o pensamento computacional é desenvolvido de maneira  multidisciplinar.',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                  decorationColor: Colors.red,
                  decorationStyle: TextDecorationStyle.wavy,
                  fontSize: 20.0,
                ),
              ),
            ),

            //texto 2
            Container(
              margin: const EdgeInsets.all(30.0),
              padding: const EdgeInsets.all(10.0),
              decoration: myBoxDecoration(), //       <--- BoxDecoration here
              child: Text('Todas as atividades serão de cunho tecnológico com objetivo de despertar no aluno o interesse  no desenvolvimento  do pensamento computacional como primórdio e  interesse nas linguagens de programação, consequentemente a partir disso ele poderá desenvolver habilidades tecnológicas.',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.black,
                  decorationColor: Colors.red,
                  decorationStyle: TextDecorationStyle.wavy,
                  fontSize: 20.0,
                ),
              ),
            ),

          ]
          ),
        ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    color: Colors.teal[100],
    border: Border.all(
      color: Colors.teal, //                   <--- border color
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(10.0) //         <--- border radius here
    ),
  );
}