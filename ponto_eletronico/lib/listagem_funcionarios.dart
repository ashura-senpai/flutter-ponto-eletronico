import 'package:flutter/material.dart';
import 'models.dart'; // Importar as classes de domínio

class ListagemFuncionarios extends StatelessWidget {
  final List<Funcionario> funcionarios;

  ListagemFuncionarios({required this.funcionarios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Funcionários'),
      ),
      body: ListView.builder(
        itemCount: funcionarios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(funcionarios[index].nome),
          );
        },
      ),
    );
  }
}
