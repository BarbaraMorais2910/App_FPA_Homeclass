import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'form_disciplina_screen.dart';
import 'disciplina_lib/app_theme.dart';

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}



class _PaginaInicialState extends State<PaginaInicial> {


  void sendData() {
    http.post("https://appeducadb.firebaseio.com/appeducadb.json",
        body: json.encode({
          'firstName': "Joao",
          'lastName': "algume",
          'email': "algu@gma",
        }));
  }

  Future<void> getData() async {
    final response = await http.get("https://appeducadb.firebaseio.com/appeducadb.json?");
    final extractedData = json.decode(response.body);
    print(extractedData);
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => FormDisciplinaScreen(),
      ),
    );
  }

  void alert() {
    print("Vamos testar");
    //sendData();
    //getData();
    moveTo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar',
        child: Icon(Icons.add),
        onPressed: (){
          alert();
        },
      ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/mensagem2.jpg"),
              //fit: BoxFit.cover,
              fit: BoxFit.fill
            ),
          ),

          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getTimeBoxUI('Seja bem vindo!', 'Olá! Vamos aprender de forma prática que  a computação faz parte do cotidiano social e o pensamento computacional é desenvolvido de maneira  multidisciplinar.'),
            //texto 1
//            Container(
//              margin: const EdgeInsets.all(30.0),
//              padding: const EdgeInsets.all(10.0),
//              decoration: myBoxDecoration(), //       <--- BoxDecoration here
//              child: Text('Olá! Vamos aprender de forma prática que  a computação faz parte do cotidiano social e o pensamento computacional é desenvolvido de maneira  multidisciplinar.',
//                textDirection: TextDirection.ltr,
//                style: TextStyle(
//                  color: Colors.black,
//                  decorationColor: Colors.red,
//                  decorationStyle: TextDecorationStyle.wavy,
//                  fontSize: 20.0,
//                ),
//              ),
//            ),
            getTimeBoxUI('Nosso principal objetivo:', 'Todas as atividades serão de cunho tecnológico com objetivo de despertar no aluno o interesse  no desenvolvimento  do pensamento computacional como primórdio e  interesse nas linguagens de programação, consequentemente a partir disso ele poderá desenvolver habilidades tecnológicas.'),
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




Widget getTimeBoxUI(String text1, String txt2) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppTheme.nearlyWhite,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.27,
                color: Colors.teal,
              ),
            ),
            Text(
              txt2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                letterSpacing: 0.27,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}