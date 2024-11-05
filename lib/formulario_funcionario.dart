import 'package:flutter/material.dart';
import 'models.dart';

class FormularioFuncionario extends StatelessWidget {
  final Function(Funcionario) onAddFuncionario;

  FormularioFuncionario({required this.onAddFuncionario});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Funcionário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Nome do Funcionário'),
            ),
            ElevatedButton(
              onPressed: () {
                final nome = _controller.text;
                if (nome.isNotEmpty) {
                  onAddFuncionario(
                      Funcionario(nome: nome, administradores: []));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Funcionário adicionado!')),
                  );
                  _controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, insira um nome')),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
