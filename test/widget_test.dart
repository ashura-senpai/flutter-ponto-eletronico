import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:ponto_eletronico/formulario_funcionario.dart';
import 'package:ponto_eletronico/models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Formulário de Funcionário Widget Test', () {
    testWidgets('Deve adicionar um novo funcionário',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(MaterialApp(
        home: FormularioFuncionario(
          onAddFuncionario: (Funcionario funcionario) {
            // Aqui você pode adicionar lógica para manipular o funcionário
          },
        ),
      ));

      // Preencher o campo de texto
      await tester.enterText(find.byType(TextFormField), 'Pedro');

      // Clicar no botão "Salvar"
      await tester.tap(find.text('Salvar'));
      await tester.pump(); // Atualizar a árvore de widgets

      // Verificar se a ação do botão resultou em um snackbar
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Funcionário adicionado!'), findsOneWidget);
    });
  });
}
