class TimezoneHelper {
  static String getIANATimezone() {
    return DateTime.now().timeZoneName;
  }

  static String getDefaultTimezone() {
    return 'UTC';
  }
}
