import 'package:flutter/material.dart';
import 'form_cadastro.dart';

import 'package:app_educa_pc/pages/disciplina_lib/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Erro"),
    content: Text("Verifique o login ou a senha!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


List<Usuario> listusuarios=[];

Future<List<Usuario>> fetchUsuarios() async {
  final response =
  await http.get('https://appeducadb.firebaseio.com/usuarios.json?');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    final extractedData = json.decode(response.body);
    List<Usuario> usuarios=new List<Usuario>();

    extractedData.forEach((key, value) {
      usuarios.add(Usuario(
        nome: value['nome'],
        email: value['email'],
        senha: value['senha'],
        confsenha: value['confsenha'],
      ));
    });

    listusuarios=usuarios.toList();

    return usuarios.toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

//Future<void> getData() async {
//  final response = await http.get("https://appeducadb.firebaseio.com/usuarios.json?nome=");
//  final extractedData = json.decode(response.body);
//  print(extractedData);
//}


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AnimationController animationController;
  Future<List<Usuario>> _futureUsuarios;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _contrUser = TextEditingController();
  final TextEditingController _contrSenha = TextEditingController();

  String _usuario, _senha;

  void _submit(){
    final form = formKey.currentState;
    if(form.validate()) {
        _usuario=_contrUser.text;
        _senha=_contrSenha.text;

        bool isUserOk=false;
        if(listusuarios.isNotEmpty) {
          listusuarios.forEach((user) {
            if (user.nome == _usuario && user.senha == _senha) {
              isUserOk = true;
            }
          });
        }
        if(isUserOk) {
          form.save();
          _performLogin();
        }
        else{
          showAlertDialog(context);
        }
    }
  }

  void _performLogin() {
    Navigator.of(context).pushNamed('/homepage');
  }

  void moveToCadastro() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => FormCadastro(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    fetchUsuarios();

    var loginBtn = new MaterialButton(
      onPressed: _submit,
      height: 40.0,
      minWidth: double.infinity,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: new Text("Entrar"),
    );

    var registerBtn = new MaterialButton(
      onPressed: (){
        moveToCadastro();
      },
      height: 40.0,
      minWidth: double.infinity,
      color: Colors.teal[200],
      textColor: Colors.white,
      child: new Text("Novo cadastro"),
    );


    var loginForm = new ListView(
      children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              color: Colors.blue.shade50,
              width: double.infinity,
              height: 250.0,
              child: new Padding(
                padding: const EdgeInsets.all(25.0),
                //child: new FlutterLogo(),
                child: new Image(
                    image: new AssetImage("assets/images/logo.png")),
              ),
            ),
            new Divider(
              height: 1.0,
              color: Theme.of(context).primaryColor,
            ),
            new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(controller: _contrUser,
                        onSaved: (val) => _usuario = val,
                        validator: (val) {
                          return val.isEmpty
                              ? "Digite seu usuário"
                              : null;
                        },
                        decoration: new InputDecoration(labelText: "Usuário"),
                      ),
                      new Padding(
                          padding: const EdgeInsets.only(bottom: 10.0)
                      ),
                      new TextFormField(controller: _contrSenha,
                        onSaved: (val) => _senha = val,
                        validator: (val) {
                          return val.isEmpty
                              ? "Digite sua senha"
                              : null;
                        },
                        obscureText: true,
                        decoration: new InputDecoration(labelText: "Senha"),
                      ),
                      new Padding(
                          padding: const EdgeInsets.only(bottom: 10.0)
                      ),
                      _isLoading ? new CircularProgressIndicator() : loginBtn,
                      new Padding(
                          padding: const EdgeInsets.only(bottom: 10.0)
                      ),
                      _isLoading ? new CircularProgressIndicator() : registerBtn
                    ],
                  )
              ),
            ),
          ],
        ),



      ],
    );

    return Scaffold(
      key: scaffoldKey,
      body: loginForm,
    );
  }
}