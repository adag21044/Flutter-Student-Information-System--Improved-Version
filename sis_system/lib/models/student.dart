class Student {
  String name;
  double midterm;
  double finalScore;

  Student({required this.name, this.midterm = 0.0, this.finalScore = 0.0});

  double calculateAverage() {
    return (midterm * 0.4) + (finalScore * 0.6);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'midterm': midterm,
      'finalScore': finalScore,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'],
      midterm: map['midterm'],
      finalScore: map['finalScore'],
    );
  }
}
