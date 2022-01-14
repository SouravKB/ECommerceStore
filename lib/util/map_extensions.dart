extension RemoveIf<K, V> on Map<K, V> {
  bool removeIf(K key, bool Function(V? value) predicate) {
    if (predicate(this[key])) {
      remove(key);
      return true;
    } else {
      return false;
    }
  }
}
