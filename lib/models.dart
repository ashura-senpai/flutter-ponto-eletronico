class Funcionario {
  String nome;
  List<Administrador> administradores;

  Funcionario({required this.nome, required this.administradores});
}

class Administrador {
  String nome;
  List<Funcionario> funcionarios;

  Administrador({required this.nome, required this.funcionarios});
}
