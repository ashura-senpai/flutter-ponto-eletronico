import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          onAddFuncionario: (Funcionario funcionario) {},
        ),
      ));

      await tester.enterText(find.byType(TextFormField), 'Pedro');

      await tester.tap(find.text('Salvar'));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Funcionário adicionado!'), findsOneWidget);
    });
  });
}
