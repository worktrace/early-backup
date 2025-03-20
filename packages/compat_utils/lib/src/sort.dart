import 'dart:collection';

/// Sort [nodes] according to their dependencies,
/// that all dependencies of a node must be sorted after the node itself.
/// Once there's a cycle in the dependencies graph, an exception will be thrown.
///
/// # Nullable Attention
///
/// The [nodes] must be ensured that all dependencies are valid keys inside
/// the map, or it will cause nullable exceptions.
/// You may use [resolveDependencies] to ensure that before this function,
/// which can be omitted when already ensured to improve performance.
List<String> sortDependencies(Map<String, Set<String>> nodes) {
  final queue = Queue<String>();
  final sorted = <String>[];
  final inDegrees = calculateInDegrees(nodes)..forEach((node, inDegree) {
    if (inDegree == 0) queue.addLast(node);
  });

  while (queue.isNotEmpty) {
    final current = queue.removeFirst();
    sorted.add(current);
    for (final neighbor in nodes[current]!) {
      inDegrees[neighbor] = inDegrees[neighbor]! - 1;
      if (inDegrees[neighbor] == 0) queue.addLast(neighbor);
    }
  }

  if (sorted.length != nodes.length) throw Exception('cycle dependencies');
  return sorted;
}

/// Calculate in-degree for each node in the dependencies graph.
/// Usually called for [sortDependencies].
Map<String, int> calculateInDegrees(Map<String, Set<String>> nodes) {
  final inDegrees = <String, int>{};
  for (final node in nodes.keys) inDegrees[node] = 0;
  for (final dependencies in nodes.values) {
    for (final dependency in dependencies) {
      inDegrees[dependency] = (inDegrees[dependency] ?? 0) + 1;
    }
  }
  return inDegrees;
}

/// Ensure that all dependencies inside the graph are valid key inside [nodes].
/// Or it might cause nullable exception when running [sortDependencies].
Map<String, Set<String>> resolveDependencies(Map<String, Set<String>> nodes) {
  final resolved = {...nodes};
  for (final dependencies in nodes.values) {
    for (final dependency in dependencies) {
      if (resolved[dependency] == null) resolved[dependency] = {};
    }
  }
  return resolved;
}
