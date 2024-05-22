extension PrintAndReturnExtension<T> on T {
  T printed({ String? name = null }) {
    if (name != null) {
      print('$name: $this');
    } else {
      print(this);
    }
    
    return this;
  }
}
