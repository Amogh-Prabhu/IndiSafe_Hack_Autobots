class Source {
  String id;
  String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> jason) {
    return Source(id: jason['id'], name: jason['name']);
  }
}
