import 'dart:convert';

class Usuario{
  Usuario({
    this.nome='',
    this.email='',
    this.senha='',
    this.confsenha='',
  });

  String nome;
  String email;
  String senha;
  String confsenha;

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      confsenha: json['confsenha'],
    );
  }

}