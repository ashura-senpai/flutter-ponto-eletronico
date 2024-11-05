import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ponto_eletronico/formulario_funcionario.dart';
import 'package:ponto_eletronico/models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Formulário de Funcionário Tests', () {
    testWidgets('Deve adicionar um novo funcionário e exibir SnackBar',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      Funcionario? funcionarioAdicionado;

      await tester.pumpWidget(MaterialApp(
        home: FormularioFuncionario(
          onAddFuncionario: (Funcionario funcionario) {
            funcionarioAdicionado = funcionario;
          },
        ),
      ));

      await tester.enterText(find.byType(TextFormField), 'João');

      await tester.tap(find.text('Salvar'));
      await tester.pump();

      expect(funcionarioAdicionado?.nome, 'João');

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Funcionário adicionado!'), findsOneWidget);
    });

    testWidgets('Não deve adicionar um funcionário sem nome',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});

      Funcionario? funcionarioAdicionado;

      await tester.pumpWidget(MaterialApp(
        home: FormularioFuncionario(
          onAddFuncionario: (Funcionario funcionario) {
            funcionarioAdicionado = funcionario;
          },
        ),
      ));

      await tester.tap(find.text('Salvar'));
      await tester.pump();

      expect(funcionarioAdicionado, isNull);

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Por favor, insira um nome'), findsOneWidget);
    });
  });
}
