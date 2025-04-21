import 'dart:collection';

typedef DependenciesGraph<T> = Map<T, Set<T>>;
typedef InDegrees<T> = Map<T, int>;

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
List<T> sortDependencies<T>(DependenciesGraph<T> nodes) {
  final queue = Queue<T>();
  final sorted = <T>[];
  final inDegrees = calculateInDegrees(nodes)
    ..forEach((node, inDegree) {
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

  if (sorted.length != nodes.length) {
    final nodesInCycle = nodes.keys.where((node) => !sorted.contains(node));
    throw Exception('cycle dependencies detected between nodes: $nodesInCycle');
  }
  return sorted;
}

/// Calculate in-degree for each node in the dependencies graph.
/// Usually called for [sortDependencies].
InDegrees<T> calculateInDegrees<T>(DependenciesGraph<T> nodes) {
  final inDegrees = <T, int>{};
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
DependenciesGraph<T> resolveDependencies<T>(DependenciesGraph<T> nodes) {
  final resolved = {...nodes};
  for (final dependencies in nodes.values) {
    for (final dependency in dependencies) {
      if (resolved[dependency] == null) resolved[dependency] = {};
    }
  }
  return resolved;
}
