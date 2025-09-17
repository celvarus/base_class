class Vehicle {
  final String brand;
  final String model;
  int _speed; // private field (encapsulated)

  Vehicle({required this.brand, required this.model, int initialSpeed = 0})
      : _speed = initialSpeed;

  // Getter
  int get speed => _speed;

  // Setter with validation
  set speed(int value) {
    if (value < 0) {
      throw ArgumentError('Speed cannot be negative.');
    }
    _speed = value;
  }

  // Method 1: Accelerate
  void accelerate(int amount) {
    if (amount <= 0) {
      print('Acceleration must be positive.');
      return;
    }
    _speed += amount;
    print('$brand $model accelerates by $amount km/h → Speed: $_speed km/h');
  }

  // Method 2: Brake
  void brake(int amount) {
    if (amount <= 0) {
      print('Brake value must be positive.');
      return;
    }
    if (amount > _speed) {
      _speed = 0;
    } else {
      _speed -= amount;
    }
    print('$brand $model slows down by $amount km/h → Speed: $_speed km/h');
  }

  String info() => 'Vehicle($brand $model) — Speed: $_speed km/h';
}
