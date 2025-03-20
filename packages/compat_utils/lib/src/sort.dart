/// Sort [nodes] according to their dependencies,
/// that all dependencies of a node must be sorted before the node itself.
/// Once there's a cycle in the dependencies graph, an exception will be thrown.
List<String> sortDependencies(Map<String, Set<String>> nodes) {
  return [];
}

/// Calculate in-degree for each node in the dependencies graph.
/// Usually called for [sortDependencies].
Map<String, int> calculateInDegrees(Map<String, Set<String>> nodes) {
  final buffer = <String, int>{};
  for (final node in nodes.keys) buffer[node] = 0;
  for (final dependencies in nodes.values) {
    for (final dependency in dependencies) {
      buffer[dependency] = (buffer[dependency] ?? 0) + 1;
    }
  }
  return buffer;
}
