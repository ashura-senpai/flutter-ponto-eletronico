import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockClient extends Mock implements http.Client {}

void main() {
  group('HTTP Mock Tests', () {
    test('Testar filtro de funcionário', () async {
      final client = MockClient();

      // Simula uma resposta da API
      when(client.get(Uri.parse('https://api.exemplo.com/funcionarios')))
          .thenAnswer((_) async => http.Response(
              jsonEncode([
                {'nome': 'Ana'},
                {'nome': 'Carlos'}
              ]),
              200));

      // Chama a função que usa o cliente
      final response =
          await client.get(Uri.parse('https://api.exemplo.com/funcionarios'));
      final List<dynamic> funcionarios = jsonDecode(response.body);

      // Filtrar funcionários com nome 'Carlos'
      final filtered =
          funcionarios.where((f) => f['nome'] == 'Carlos').toList();

      expect(filtered.length, 1);
      expect(filtered[0]['nome'], 'Carlos');
    });
  });
}
