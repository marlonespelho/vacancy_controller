# vacancy_controller

A Flutter project for parking spot management, using MobX for state management, as well as unit and integration tests.

## Getting Started
## Running the Project
- To run the project, you need to have Flutter installed. You can follow the steps at https://docs.flutter.dev/get-started/install.
- After installing Flutter, first run the command `flutter pub get` in the project folder.
- Then, run the command `flutter run` to start the project.

## Pre-commit Guide
1. Run the command `dart run build_runner build --delete-conflicting-outputs` to generate MobX files;
2. Run the command `dart analyze` to check for errors and warnings;
3. Run the command `dart format -l 120 .` to format the code;
4. Run the command `flutter test` to make sure all tests are passing;
5. Run the command `flutter test integration_test` to make sure all integration tests are passing.

# Tests

### Integration Tests
- To run integration tests, use the following guide:
    - Run the command `flutter test integration_test` in your IDE;

### Unit Tests
- To run unit tests, run the command `flutter test test/main.dart` in the project folder.
