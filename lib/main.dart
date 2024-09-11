import 'package:flutter/material.dart';
import 'home_page.dart';
import 'listagem_funcionarios.dart';
import 'formulario_funcionario.dart';
import 'models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Funcionario> funcionarios = [];

  @override
  void initState() {
    super.initState();
    _loadFuncionarios();
  }

  // Carregar funcionários de shared_preferences
  void _loadFuncionarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? funcionariosJson = prefs.getString('funcionarios');
    if (funcionariosJson != null) {
      List<dynamic> funcionariosList = jsonDecode(funcionariosJson);
      setState(() {
        funcionarios = funcionariosList
            .map((funcionarioMap) => Funcionario(
                nome: funcionarioMap['nome'], administradores: []))
            .toList();
      });
    }
  }

  // Salvar funcionários em shared_preferences
  void _saveFuncionarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> funcionariosMap = funcionarios
        .map((funcionario) => {'nome': funcionario.nome})
        .toList();
    String funcionariosJson = jsonEncode(funcionariosMap);
    prefs.setString('funcionarios', funcionariosJson);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ponto Eletrônico',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/listagem': (context) => ListagemFuncionarios(funcionarios: funcionarios),
        '/formulario': (context) => FormularioFuncionario(
          onAddFuncionario: (funcionario) {
            setState(() {
              funcionarios.add(funcionario);
              _saveFuncionarios();
            });
          },
        ),
      },
    );
  }
}
