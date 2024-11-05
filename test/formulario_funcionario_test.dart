import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_eletronico/formulario_funcionario.dart';
import 'package:ponto_eletronico/models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Formulário de Funcionário Tests', () {
    testWidgets('Deve adicionar um novo funcionário e exibir SnackBar',
        (WidgetTester tester) async {
      // Inicializa as SharedPreferences em modo de teste
      SharedPreferences.setMockInitialValues({});

      // Variável para armazenar o funcionário adicionado
      Funcionario? funcionarioAdicionado;

      // Cria um Widget de teste com o Formulário de Funcionário
      await tester.pumpWidget(MaterialApp(
        home: FormularioFuncionario(
          onAddFuncionario: (Funcionario funcionario) {
            funcionarioAdicionado =
                funcionario; // Armazena o funcionário adicionado
          },
        ),
      ));

      // Preencher o campo de texto
      await tester.enterText(find.byType(TextFormField), 'João');

      // Clicar no botão "Salvar"
      await tester.tap(find.text('Salvar'));
      await tester.pump(); // Atualiza a árvore de widgets

      // Verifica se o funcionário foi adicionado corretamente
      expect(funcionarioAdicionado?.nome, 'João');

      // Verifica se um SnackBar é exibido com a mensagem correta
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

      // Clicar no botão "Salvar" sem preencher o campo
      await tester.tap(find.text('Salvar'));
      await tester.pump(); // Atualiza a árvore de widgets

      // Verifica se o funcionário não foi adicionado
      expect(funcionarioAdicionado, isNull);

      // Verifica se um SnackBar é exibido com a mensagem correta
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Por favor, insira um nome'), findsOneWidget);
    });
  });
}
