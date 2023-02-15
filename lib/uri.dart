Uri Function(String value) uri(String host) {
  return (String value) {
    return Uri.parse("$host/$value");
  };
}
