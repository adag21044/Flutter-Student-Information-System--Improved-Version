// A simple Professor class to represent professor information
class Professor {
  String name; // Stores the professor's name

  // Constructor to initialize a Professor instance with a required name
  Professor({required this.name});

  // Converts the Professor instance to a map structure for storage or JSON conversion
  Map<String, dynamic> toMap() {
    return {
      'name': name, // Adds the professor's name to the map with the key 'name'
    };
  }

  // Factory constructor to create a Professor instance from a map (useful for deserialization)
  factory Professor.fromMap(Map<String, dynamic> map) {
    return Professor(
      name: map['name'], // Retrieves the 'name' value from the map and assigns it to the name property
    );
  }
}
