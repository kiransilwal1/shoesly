class ColorEntity {
  final String name;
  final String colorCode;

  ColorEntity({required this.name, required this.colorCode});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final ColorEntity otherColor = other as ColorEntity;
    return name == otherColor.name && colorCode == otherColor.colorCode;
  }

  @override
  int get hashCode => name.hashCode ^ colorCode.hashCode;
}
