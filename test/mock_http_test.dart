import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('HTTP Mock Tests', () {
    late MockClient client;

    setUp(() {
      client = MockClient();
    });

    test('Testar filtro de funcionário', () async {
      when(() => client.get(Uri.parse('https://example.com/funcionarios')))
          .thenAnswer((_) async => http.Response(
              jsonEncode([
                {'id': 1, 'nome': 'João'},
                {'id': 2, 'nome': 'Maria'},
              ]),
              200));

      final response =
          await client.get(Uri.parse('https://example.com/funcionarios'));

      expect(response.statusCode, 200);
      List<dynamic> funcionarios = jsonDecode(response.body);
      expect(funcionarios.length, 2);
      expect(funcionarios[0]['nome'], 'João');
    });
  });
}
