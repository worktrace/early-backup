import 'dart:io';

abstract class ClientStore {
  const ClientStore();
}

class FileStore extends ClientStore {
  const FileStore(this.root);

  factory FileStore.setup(Directory root) {
    final store = FileStore(root);
    store.root.createSync(recursive: true);
    return store;
  }

  final Directory root;
}
