import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/loja.dart';
import '../models/cardapio.dart';

class ApiService {
  final String baseUrl = 'https://delivery-umtc.onrender.com';

  // Buscar todas as lojas
  Future<List<Loja>> buscarLojas() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/lojas'),
    );

    // 1. Verificar se o status é 200
    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao carregar lojas: ${response.statusCode}',
      );
    }

    // 2. Converter a resposta para JSON
    final Map<String, dynamic> json = jsonDecode(response.body);

    // 3. Verificar se success é verdadeiro
    if (json['success'] != true) {
      throw Exception('A API retornou um erro ao buscar lojas.');
    }

    // 4. Extrair SOMENTE a lista data
    final List<dynamic> data = json['data'];

    // 5. Converter cada item em um objeto Loja
    return data
        .map((item) => Loja.fromJson(item))
        .toList();
  }

  // Buscar os cardápios de uma loja
  Future<List<Cardapio>> buscarCardapios(int id_loja) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/lojas/$id_loja/cardapios'),
    );

    // 1. Verificar se o status é 200
    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao carregar cardápios: ${response.statusCode}',
      );
    }

    // 2. Converter a resposta para JSON
    final Map<String, dynamic> json = jsonDecode(response.body);

    // 3. Verificar se success é verdadeiro
    if (json['success'] != true) {
      throw Exception('A API retornou um erro ao buscar cardápios.');
    }

    // 4. Extrair SOMENTE a lista data
    final List<dynamic> data = json['data'];

    // 5. Converter cada item em um objeto Cardapio
    return data
        .map((item) => Cardapio.fromJson(item))
        .toList();
  }
}