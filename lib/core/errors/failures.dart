class Failures {
  final String errorMessage;
  Failures({required this.errorMessage});
}

class ServerFailure extends Failures {
  ServerFailure({required super.errorMessage});
}
