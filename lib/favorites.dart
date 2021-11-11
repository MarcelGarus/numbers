class Favorites {
  final _facts = <String>[];
  List<String> get facts => _facts;

  void toggle(String fact) {
    if (_facts.contains(fact)) {
      _facts.remove(fact);
    } else {
      _facts.add(fact);
    }
  }
}
