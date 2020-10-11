import 'app_theme.dart';
import 'models/disciplina.dart';
import 'package:app_educa_pc/main.dart';
import 'package:flutter/material.dart';

import 'package:app_educa_pc/pages/disciplina_lib/models/questoes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app_educa_pc/pages/disciplina_lib/disciplina_info_screen.dart';


Future<List<Questoes>> fetchQuestoes() async {
  final response =
  await http.get('https://appeducadb.firebaseio.com/atividades.json?');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

      final extractedData = json.decode(response.body);
      List<Questoes> questoes=new List<Questoes>();

      extractedData.forEach((key, value) {

        String tipo;
        final lista=[['matematica','Matemática'], ['portugues','Português'], ['quimica','Química']];
        for(var i=0; i<lista.length; i++){
          if(value['tipo']==lista[i][0]){
            tipo=lista[i][1];
          }
        }

        questoes.add(Questoes(
          titulo: value['titulo'],
          ano: value['ano'],
          duracao: value['duracao'],
          tipo: tipo,
          questao: value['questao'],
        ));
      });


    return questoes.toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


class TodasDisciplinaListView extends StatefulWidget {
  const TodasDisciplinaListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _TodasDisciplinaListViewState createState() => _TodasDisciplinaListViewState();
}

class _TodasDisciplinaListViewState extends State<TodasDisciplinaListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Future<List<Questoes>> _futureQuestoes;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    _futureQuestoes=fetchQuestoes();
  }




  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: FutureBuilder<List<Questoes>>(
        future: _futureQuestoes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final questoes=snapshot.data;
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FutureBuilder<bool>(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    } else {
                      return GridView(
                        padding: const EdgeInsets.all(8),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: List<Widget>.generate(
                          questoes.length,
                              (int index) {
                            final int count = questoes.length;
                            final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController,
                                curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController.forward();
                            return DisciplinaView(
                              callback: () {
                                widget.callBack();
                              },
                              disciplina: questoes[index],
                              animation: animation,
                              animationController: animationController,
                            );
                          },
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 32.0,
                          crossAxisSpacing: 32.0,
                          childAspectRatio: 0.8,
                        ),
                      );
                    }
                  },
                ),
              );
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        };
          return CircularProgressIndicator();
        }

    ),
    );
  }
}


class DisciplinaView extends StatelessWidget {
  const DisciplinaView(
      {Key key,
        this.disciplina,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Questoes disciplina;
  final AnimationController animationController;
  final Animation<dynamic> animation;


  @override
  Widget build(BuildContext context) {

    void moveTo(Questoes disc) {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => DisciplinaInfoScreen(disciplina: disc),
        ),
      );
    }



    String screenTitulo;
    if(disciplina.titulo.length>20){
      screenTitulo=disciplina.titulo.substring(0,20)+'...';
    }
    else{
      screenTitulo=disciplina.titulo+'...';
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                moveTo(disciplina);
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              disciplina.tipo,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              screenTitulo,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                letterSpacing: 0.27,
                                                color: AppTheme.nearlyBlack,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.grey.withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.28,
                                child: Image.asset(disciplina.getPath())),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



