import 'binding_string.dart';
import 'writer.dart';

abstract class Binding {
  /// Holds the Unified Symbol Resolution string obtained from libclang.
  final String usr;

  /// The name as it was in C.
  final String originalName;

  /// Binding name to generate, may get changed to resolve name conflicts.
  String name;

  final String? dartDoc;

  Binding({
    required this.usr,
    required this.originalName,
    required this.name,
    this.dartDoc,
  });

  /// Get all dependencies, including itself and save them in [dependencies].
  void addDependencies(Set<Binding> dependencies);

  /// Converts a Binding to its actual string representation.
  ///
  /// Note: This does not print the typedef dependencies.
  /// Must call [getTypedefDependencies] first.
  BindingString toBindingString(Writer w);
}
