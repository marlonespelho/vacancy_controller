import 'package:parking_controller/core/models/main.dart';

class Paginate {
  List<ModelInterface>? _data;
  final int _count;
  final String? _nextPage;
  final String? _lastPage;
  final int _limit;

  Paginate({
    List<ModelInterface>? data,
    int count = 0,
    String? nextPage,
    String? previousPage,
    int limit = 20,
  })  : _count = count,
        _nextPage = nextPage,
        _lastPage = previousPage,
        _data = data,
        _limit = limit;

  factory Paginate.fromJson(
    Map<String, dynamic> json, {
    List<ModelInterface>? data,
  }) {
    return Paginate(
      data: data,
      count: json['count'] ?? 0,
      nextPage: json['next'],
      previousPage: json['previous'],
    );
  }

  List<ModelInterface>? get data => _data;

  int get count => _count;

  String? get nextPage => _nextPage;

  String? get previousPage => _lastPage;

  int get limit => _limit;
}
