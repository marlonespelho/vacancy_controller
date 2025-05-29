# vacancy_controller

Um projeto Flutter para realizar o controle de vagas de estacionamento, utilizando o MobX para gerenciamento de estado e testes unitários e de integração.

## Primeiros Passos
## Executar o projeto
- Para executar o projeto, você precisa ter o Flutter instalado. Você pode seguir os passos em https://docs.flutter.dev/get-started/install.
- Após instalar o Flutter, primeiro execute o comando `flutter pub get` na pasta do projeto.
- Depois, execute o comando `flutter run` para executar o projeto.

## Guia Antes de Comitar
1. Execute o comando `dart run build_runner build --delete-conflicting-outputs` para gerar os arquivos MobX;
2. Execute o comando `dart analyze` para analisar erros e avisos;
3. Execute o comando `dart format -l 120 .` para formatar o código;
4. Execute o comando `flutter test` para verificar se todos os testes estão passando;
5. Execute o comando `flutter test integration_test` para verificar se todos os testes de integração estão passando.

# Testes

### Testes de Integração
- Para executar os testes de integração, use o seguinte guia:
    - Execute o comando `flutter test integration_test` no seu IDE;

### Testes Unitários
- Para executar os testes unitários, execute o comando `flutter test test/main.dart` na pasta do projeto.