import 'package:equatable/equatable.dart';

class ServerException implements Exception {
  final String errorText;
  ServerException({required this.errorText});
}

class LocalCacheException implements Exception {
  final String errorText;
  LocalCacheException({required this.errorText});
}

class Failure extends Equatable implements Exception {
  final String? errorText;
  Failure({this.errorText = "Erro Inesperado"});

  @override
  List<Object?> get props => [errorText];
}

class LocalFailure extends Failure {
  LocalFailure({String? errorText}) : super(errorText: errorText);
}
