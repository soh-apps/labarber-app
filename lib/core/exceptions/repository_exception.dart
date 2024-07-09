class RepositoryException implements Exception {
  final String message;
  RepositoryException({
    required this.message,
  });
}

class RepositoryError extends RepositoryException {
  RepositoryError({required super.message});
}
