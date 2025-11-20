String getGreeting() {
  int hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return "صباح الخير";
  } else if (hour >= 12 && hour < 18) {
    return "مساء الخير"; // بعد الظهر
  } else {
    return "مساء الخير"; // الليل
  }
}
