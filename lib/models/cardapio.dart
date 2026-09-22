import 'produto.dart';

class Cardapio {
  final int id_cardapio;
  final int cardapio_id_loja;
  final String cardapio_nome;
  final bool cardapio_ativo;
  final List<dynamic> disponibilidades;
  final List<Produto> produtos;

  Cardapio({
    required this.id_cardapio,
    required this.cardapio_id_loja,
    required this.cardapio_nome,
    required this.cardapio_ativo,
    required this.disponibilidades,
    required this.produtos,
  });

  factory Cardapio.fromJson(Map<String, dynamic> json) {
    final listaProdutos = json['produtos'] as List? ?? [];

    return Cardapio(
      id_cardapio: json['id_cardapio'],
      cardapio_id_loja: json['cardapio_id_loja'],
      cardapio_nome: json['cardapio_nome'],
      cardapio_ativo: json['cardapio_ativo'],
      disponibilidades: json['disponibilidades'] ?? [],
      produtos: listaProdutos
          .where((item) =>
              item is Map<String, dynamic> &&
              item['produto'] != null)
          .map((item) => Produto.fromJson(item['produto']))
          .toList(),
    );
  }
}