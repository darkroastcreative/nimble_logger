import 'package:nimble_logger/nimble_logger.dart';
import 'package:nimble_logger/src/utility_functions.dart';

void main() {
  NimbleLogger logger = NimbleLogger([LoggingMethod.console]);
  logger.setFileLoggingPath(
      '/Users/david/Documents/Logs/TestLog ${getSanitizedTimestampString(DateTime.now())}.log');
  logger.setFileLoggingState(true);
  logger.logMessage('Hello, world!');
}
