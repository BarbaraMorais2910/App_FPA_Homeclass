import 'package:flutter/material.dart';
import 'pagina_home.dart';
import 'pagina_diciplina.dart';
import 'pagina_sair.dart';


class MenuItem {
  String titulo;
  IconData icon;
  MenuItem(this.titulo, this.icon);
}

class HomePage extends StatefulWidget {

  final menuItens = [
    new MenuItem("Home", Icons.home),
    new MenuItem("Disciplinas", Icons.add_to_photos),
    new MenuItem("Sair", Icons.people)
  ];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}


class HomePageState extends State<HomePage> {

  _itemSelecionado(int item) {
    setState(() {
      _selecionado = item;
    });
    Navigator.of(context).pop();
  }

  _menuItem() {
    List<Widget> menu = <Widget>[];
    for(var i = 0; i < widget.menuItens.length; i++) {
      var item = widget.menuItens[i];
      menu.add(new ListTile(
        leading: new Icon(item.icon),
        title: new Text(item.titulo),
        selected: i == _selecionado,
        onTap: () => _itemSelecionado(i),
      ));
    }
    return menu;
  }

  int _selecionado = 0;
  _carregaFragmento(int carrega) {
    switch(carrega) {
      case 0: return new PaginaInicial();
      case 1: return new PaginaDisciplina();
      case 2: return new PaginaSair();
      default: return new Text('Essa página não existe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("HOMECLASS"),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Alguem"),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new AssetImage("assets/images/user.png"),
                ),
                accountEmail: new Text("alguem@gmail.com")),
            new Column(
              children: _menuItem(),
            )
          ],
        ),
      ),
      body: _carregaFragmento(_selecionado),
    );
  }
}