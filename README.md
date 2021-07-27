# Todo App

Aplicativo desenvolvido no intuito de demonstrar habilidades técnicas com flutter para processo seletivo da Exame


### Features
* Listagem de tarefas
* Filtragem de tarefas
* Criação de tarefas
* Edição de tarefas
* Remoção de tarefas
* Persistência de dados


###  O que você vai encontrar no código?
* Minha primeira implementação de Hive (Persistência de dados)
* Testes de widget, bloc, repository e datasource, utilizando mockito e bloc_test
* Componentização de código
* Clean code no geral
* Bloc Pattern e gerenciamento de estado baseado em eventos com flutter_bloc
* E uma ótima interface hehe
* NullSafety com flutter

## Pacotes principais utilizados
* [Hive](https://pub.dev/packages/hive)
* [Flutter_bloc](https://pub.dev/packages/flutter_bloc)
* [Get_it](https://pub.dev/packages/get_it)
* [bloc_test](https://pub.dev/packages/bloc_test)
* [mockito](https://pub.dev/packages/mockito)

## Instalação

- Você precisará do [Flutter](https://flutter.dev/docs/get-started/install) em seu computador
- Na pasta do projeto, abra o console e digite o seguintes compantos

```shell
// code in the project console

$ flutter pub get
$ flutter pub run build_runner watch --delete-conflict-outputs
```

---

> Muito fácil, não?


## Arquitetura

A arquitetura foi desenvolvida e baseada no Business Logic of Component (ou BLoC para os íntimos) é um padrão apresentado pelo Google. Ela possui camadas bem dividas entre elas são: UI, Bloc, Repository e Datasources.

### UI
Está parte está responsável pela renderização de componentes visuais no Flutter (Widgets), nesta camada evitamos ao máximo realizar controle lógicos.

### Bloc
Esta camada é responsável pelo controle de estado da parte visual e consumo de dados externos que preencherão a UI. Aqui também se encontra nossas streams, basicamente streams são dados que fornecessem uma sequência assíncrona de informação. A comunicação entre a UI e Bloc funcionam via estados e eventos.

### Repository
Aqui está nossa camada de implementação que conversa com o mundo interno e externo da aplicação. Basicamente ele firma um contrato com a nossa aplicação informando ao mundo externo o que deseja, sem alterar o que desejamos internamente da aplicação

### DataSource
A Datasource ela é responsável pela nossa comunicação externa que retorna para o mundo interno os nossos dados. Aqui nestá camada podemos consumir informações tanto de uma API quanto de um cache local.

## Agradecimentos