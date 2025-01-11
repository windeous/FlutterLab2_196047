class Joke {
  final int id;
  final String type;
  final String setup;
  final String punchline;

  Joke(
      {required this.id,
      required this.type,
      required this.setup,
      required this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'],
      type: json['type'],
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Joke &&
        other.setup == setup &&
        other.punchline == punchline;
  }

  @override
  int get hashCode => Object.hash(setup, punchline);
}
