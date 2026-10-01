# Delivery App

Aplicativo de Delivery desenvolvido em **Flutter** como parte de uma atividade prática de desenvolvimento mobile, com foco no consumo e na integração com uma API REST.

A aplicação permite consultar as lojas disponíveis e visualizar os cardápios e produtos associados a cada estabelecimento.

## Funcionalidades

* Listagem das lojas disponíveis;
* Consulta dos cardápios de cada loja;
* Exibição dos produtos disponíveis;
* Navegação entre a tela de lojas e a tela de cardápio;
* Tratamento dos estados de carregamento, erro e ausência de dados;
* Consumo de dados provenientes de uma API REST;
* Conversão de dados JSON em objetos Dart.

## Tecnologias utilizadas

* **Flutter**
* **Dart**
* **API REST**
* **HTTP**
* **JSON**
* **FutureBuilder**

## Estrutura do projeto

```text
lib/
├── main.dart
│
├── models/
│   ├── loja.dart
│   ├── cardapio.dart
│   └── produto.dart
│
├── services/
│   └── api_service.dart
│
└── screens/
    ├── lojas_screen.dart
    └── cardapio_screen.dart
```

### Models

A pasta `models` contém as classes responsáveis pela representação dos dados recebidos pela API.

* `Loja`: representa os dados de uma loja;
* `Cardapio`: representa os dados de um cardápio;
* `Produto`: representa os produtos disponibilizados no cardápio.

### Services

A pasta `services` contém a lógica responsável pela comunicação com a API.

O arquivo `api_service.dart` realiza as requisições HTTP e processa as respostas retornadas pelo servidor.

Os principais endpoints utilizados são:

```text
GET /api/lojas
GET /api/lojas/{id_loja}/cardapios
```

A aplicação verifica o status da requisição, valida o campo `success` e realiza a extração dos dados contidos na chave `data` da resposta JSON.

### Screens

A pasta `screens` contém as interfaces da aplicação.

* `LojasScreen`: apresenta a lista de lojas disponíveis;
* `CardapioScreen`: apresenta os produtos relacionados à loja selecionada.

A aplicação utiliza `FutureBuilder` para trabalhar com as requisições assíncronas e apresentar diferentes estados de carregamento, erro, ausência de dados e sucesso.

## Funcionamento

O fluxo principal da aplicação ocorre da seguinte maneira:

```text
API
  ↓
Requisição HTTP
  ↓
Resposta JSON
  ↓
Extração da chave "data"
  ↓
Conversão para Models
  ↓
FutureBuilder
  ↓
Interface do aplicativo
```

Ao selecionar uma loja, o respectivo `id_loja` é enviado para a tela de cardápio. Em seguida, uma nova requisição é realizada utilizando esse identificador para obter os dados correspondentes.

## Objetivo do projeto

O projeto teve como objetivo aplicar, na prática, conceitos relacionados ao desenvolvimento de aplicações mobile utilizando Flutter e Dart, especialmente:

* Consumo de APIs REST;
* Requisições HTTP assíncronas;
* Manipulação de dados JSON;
* Modelagem de dados;
* Organização de projetos;
* Navegação entre telas;
* Tratamento de diferentes estados da interface.

## Documentação da API

A aplicação utiliza uma API de Delivery disponibilizada para a atividade.

Documentação da API:

[https://delivery-umtc.onrender.com/api-docs](https://delivery-umtc.onrender.com/api-docs)

## Contexto acadêmico

Projeto desenvolvido como atividade prática de desenvolvimento de aplicativos, com foco na integração entre uma aplicação Flutter e uma API REST para consulta e apresentação de informações de lojas, cardápios e produtos.
