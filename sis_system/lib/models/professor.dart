class Professor {
  String name;

  Professor({required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Professor.fromMap(Map<String, dynamic> map) {
    return Professor(
      name: map['name'],
    );
  }
}
