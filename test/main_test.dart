import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ponto_eletronico/models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Funcionário Tests', () {
    test('Adicionar Funcionário', () {
      Funcionario funcionario = Funcionario(nome: 'João', administradores: []);
      expect(funcionario.nome, 'João');
      expect(funcionario.administradores.isEmpty, true);
    });

    test('Carregar Funcionários', () async {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'funcionarios',
          jsonEncode([
            {'nome': 'Maria'},
            {'nome': 'José'}
          ]));

      String? funcionariosJson = prefs.getString('funcionarios');
      List<dynamic> funcionariosList = jsonDecode(funcionariosJson!);
      List<Funcionario> funcionarios = funcionariosList
          .map((funcionarioMap) =>
              Funcionario(nome: funcionarioMap['nome'], administradores: []))
          .toList();

      expect(funcionarios.length, 2);
      expect(funcionarios[0].nome, 'Maria');
      expect(funcionarios[1].nome, 'José');
    });
  });
}
