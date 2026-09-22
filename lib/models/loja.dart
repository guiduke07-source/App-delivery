import 'cardapio.dart';

class Loja {
  final int id_loja;
  final String loja_nome;
  final String? loja_telefone;
  final String loja_cnpj;
  final String loja_data_cadastro;
  final List<Cardapio> cardapios;

  Loja({
    required this.id_loja,
    required this.loja_nome,
    this.loja_telefone,
    required this.loja_cnpj,
    required this.loja_data_cadastro,
    required this.cardapios,
  });

  factory Loja.fromJson(Map<String, dynamic> json) {
    return Loja(
      id_loja: json['id_loja'],
      loja_nome: json['loja_nome'],
      loja_telefone: json['loja_telefone'],
      loja_cnpj: json['loja_cnpj'],
      loja_data_cadastro: json['loja_data_cadastro'],
      cardapios: (json['cardapios'] as List)
          .map(
            (item) => Cardapio.fromJson(item),
          )
          .toList(),
    );
  }
}