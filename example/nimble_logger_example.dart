import 'package:nimble_logger/nimble_logger.dart';
import 'package:nimble_logger/src/utility_functions.dart';

void main() {
  // Declare and initialize an instance of NimbleLogger with console logging
  // enabled.
  NimbleLogger logger = NimbleLogger([LoggingMethod.console]);

  // Set path for file-based logging.
  logger.setFileLoggingPath(
      '/Users/david/Documents/Logs/TestLog ${getSanitizedTimestampString(DateTime.now())}.log');
  // Enable file-based logging.
  logger.setFileLoggingState(true);

  // Log a couple test messages to console and file.
  logger.logMessage('Hello, world!');
  logger.logError('On no!');
}
