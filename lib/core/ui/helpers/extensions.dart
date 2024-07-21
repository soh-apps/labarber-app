extension DoubleExtensions on double {
  String transformaEmReal() {
    return toStringAsFixed(2).replaceAll('.', ',');
  }
}
