import 'package:flutter/material.dart';
import 'models.dart';  // Importar as classes de domínio

class FormularioFuncionario extends StatefulWidget {
  final Function(Funcionario) onAddFuncionario;

  FormularioFuncionario({required this.onAddFuncionario});

  @override
  _FormularioFuncionarioState createState() => _FormularioFuncionarioState();
}

class _FormularioFuncionarioState extends State<FormularioFuncionario> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Funcionário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Funcionário'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Criar o novo funcionário e passar para o callback
                    Funcionario funcionario = Funcionario(
                      nome: _nomeController.text,
                      administradores: [],
                    );
                    widget.onAddFuncionario(funcionario);
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
