import 'package:flutter/material.dart';

import '../models/loja.dart';
import '../services/api_service.dart';
import 'cardapio_screen.dart';

class LojasScreen extends StatefulWidget {
  const LojasScreen({super.key});

  @override
  State<LojasScreen> createState() => _LojasScreenState();
}

class _LojasScreenState extends State<LojasScreen> {
  final ApiService apiService = ApiService();

  late Future<List<Loja>> lojasFuture;

  @override
  void initState() {
    super.initState();
    lojasFuture = apiService.buscarLojas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: FutureBuilder<List<Loja>>(
        future: lojasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return _mensagemEstado(
              icone: Icons.error_outline,
              titulo: 'Ocorreu um erro',
              descricao: 'Não foi possível carregar as lojas.',
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _mensagemEstado(
              icone: Icons.store_mall_directory_outlined,
              titulo: 'Nenhuma loja encontrada',
              descricao: 'Não existem lojas disponíveis no momento.',
            );
          }

          final lojas = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Encontre sua loja favorita',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF29263D),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Escolha uma loja para visualizar o cardápio.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 22),

              ...lojas.map(
                (loja) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardapioScreen(
                              id_loja: loja.id_loja,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(
                                Icons.storefront,
                                size: 35,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loja.loja_nome,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF29263D),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_outlined,
                                        size: 16,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          loja.loja_telefone ??
                                              'Telefone não informado',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.deepPurple,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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