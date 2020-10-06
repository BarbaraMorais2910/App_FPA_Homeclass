

//dados.forEach((value) {
//if (value == 2) {
//// how to stop?
//}
//print(value);
//});

class Disciplina {
  Disciplina({
    this.title = '',
    this.imagePath = '',
  });

  String title;
  String imagePath;

  static List<Disciplina> disciplinaList = <Disciplina>[
    Disciplina(
      imagePath: 'assets/design_course/matematica.png',
      title: 'Matemática',
    ),
    Disciplina(
      imagePath: 'assets/design_course/matematica.png',
      title: 'Matemática',
    ),
    Disciplina(
      imagePath: 'assets/design_course/matematica.png',
      title: 'Matemática',
    ),
  ];

  static List<Disciplina> todasDisciplinaList = <Disciplina>[
    Disciplina(
      imagePath: 'assets/design_course/matematica.png',
      title: 'Atividades de Matemática',
    ),
    Disciplina(
      imagePath: 'assets/design_course/portugues.png',
      title: 'Atividades de Português',
    ),
    Disciplina(
      imagePath: 'assets/design_course/quimica.png',
      title: 'Atividades de Química   ',
    ),
    Disciplina(
      imagePath: 'assets/design_course/quimica.png',
      title: 'Atividades de Química',
    ),
  ];
}
