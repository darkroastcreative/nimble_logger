/// Accepts a DateTime object and returns a sanitized version of the DateTime
/// as a String.
String getSanitizedTimestampString(DateTime dateTime) {
  // Convert the provided DateTime object to a String.
  String sanitizedDateTimeString = dateTime.toString();

  // Sanitize the DateTime String by removing dashes, colons, and periods.
  sanitizedDateTimeString = sanitizedDateTimeString.replaceAll("-", "");
  sanitizedDateTimeString = sanitizedDateTimeString.replaceAll(":", "");
  sanitizedDateTimeString = sanitizedDateTimeString.replaceAll(".", "");

  // Return the sanitized String.
  return dateTime.toString();
}
