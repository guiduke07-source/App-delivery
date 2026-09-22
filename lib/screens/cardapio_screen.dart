import 'package:flutter/material.dart';

import '../models/cardapio.dart';
import '../services/api_service.dart';

class CardapioScreen extends StatefulWidget {
  final int id_loja;

  const CardapioScreen({
    super.key,
    required this.id_loja,
  });

  @override
  State<CardapioScreen> createState() => _CardapioScreenState();
}

class _CardapioScreenState extends State<CardapioScreen> {
  final ApiService apiService = ApiService();

  late Future<List<Cardapio>> cardapiosFuture;

  @override
  void initState() {
    super.initState();
    cardapiosFuture = apiService.buscarCardapios(widget.id_loja);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cardápio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Cardapio>>(
        future: cardapiosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return _mensagemEstado(
              icone: Icons.error_outline,
              titulo: 'Erro ao carregar cardápio',
              descricao: 'Não foi possível buscar os produtos.',
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _mensagemEstado(
              icone: Icons.menu_book_outlined,
              titulo: 'Nenhum cardápio encontrado',
              descricao: 'Esta loja ainda não possui cardápios.',
            );
          }

          final cardapios = snapshot.data!;

          final produtos = cardapios
              .expand((cardapio) => cardapio.produtos)
              .toList();

          if (produtos.isEmpty) {
            return _mensagemEstado(
              icone: Icons.fastfood_outlined,
              titulo: 'Nenhum produto disponível',
              descricao:
                  'Esta loja ainda não possui produtos cadastrados.',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.fastfood_rounded,
                            size: 38,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produto.produto_nome,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF29263D),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                produto.produto_descricao,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'R\$ ${produto.produto_valor.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _mensagemEstado({
    required IconData icone,
    required String titulo,
    required String descricao,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icone,
              size: 75,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 18),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              descricao,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}