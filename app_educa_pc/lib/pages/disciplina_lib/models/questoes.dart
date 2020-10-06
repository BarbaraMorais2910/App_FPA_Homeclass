import 'dart:convert';

class Questoes{
  Questoes({
    this.titulo='',
    this.ano='',
    this.duracao='',
    this.tipo='',
    this.questao='',
  });

  String titulo;
  String ano;
  String duracao;
  String tipo;
  String questao;


  String getPath(){

    String caminho='';
    if (this.tipo=='matematica'){
        caminho='assets/design_course/matematica.png';
    }
    else if(this.tipo=='portugues'){
      caminho='assets/design_course/portugues.png';
    }
    else if(this.tipo=='quimica'){
      caminho='assets/design_course/quimica.png';
    }

    return caminho;
  }

  factory Questoes.fromJson(Map<String, dynamic> json) {
    return Questoes(
      titulo: json['titulo'],
      ano: json['ano'],
      duracao: json['duracao'],
      tipo: json['tipo'],
      questao: json['questao'],
    );
  }


}