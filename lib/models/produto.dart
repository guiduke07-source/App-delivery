class Produto {
  final int id_produto;
  final String produto_nome;
  final String produto_descricao;
  final double produto_valor;
  final String? produto_imagem;
  final bool produto_ativo;
  final int produto_id_loja;
  final int? produto_id_categoria;

  Produto({
    required this.id_produto,
    required this.produto_nome,
    required this.produto_descricao,
    required this.produto_valor,
    this.produto_imagem,
    required this.produto_ativo,
    required this.produto_id_loja,
    this.produto_id_categoria,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id_produto: json['id_produto'],
      produto_nome: json['produto_nome'],
      produto_descricao: json['produto_descricao'],
      produto_valor: (json['produto_valor'] as num).toDouble(),
      produto_imagem: json['produto_imagem'],
      produto_ativo: json['produto_ativo'],
      produto_id_loja: json['produto_id_loja'],
      produto_id_categoria: json['produto_id_categoria'],
    );
  }
}