// A simple Student class to represent a student's details and grades
class Student {
  String name;        // Stores the student's name
  double midterm;     // Stores the midterm grade
  double finalScore;  // Stores the final exam grade

  // Constructor to initialize a Student instance with required name,
  // and optional midterm and finalScore, defaulting to 0.0
  Student({required this.name, this.midterm = 0.0, this.finalScore = 0.0});

  // Method to calculate the average grade based on midterm and final grades
  double calculateAverage() {
    // The average is calculated as 40% of midterm and 60% of finalScore
    return (midterm * 0.4) + (finalScore * 0.6);
  }

  // Converts the Student instance to a map structure for storage or JSON conversion
  Map<String, dynamic> toMap() {
    return {
      'name': name,          // Adds the student's name to the map with the key 'name'
      'midterm': midterm,    // Adds the midterm score with the key 'midterm'
      'finalScore': finalScore, // Adds the final score with the key 'finalScore'
    };
  }

  // Factory constructor to create a Student instance from a map (useful for deserialization)
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'],           // Retrieves the 'name' value from the map and assigns it to the name property
      midterm: map['midterm'],     // Retrieves the 'midterm' value from the map and assigns it to midterm
      finalScore: map['finalScore'], // Retrieves the 'finalScore' value from the map and assigns it to finalScore
    );
  }
}
