String getGreeting() {
  int hour = DateTime.now().hour;

  if (hour >= 0 && hour < 12) {
    return "صباح الخير";
  } else {
    return "مساء الخير";
  }
}
