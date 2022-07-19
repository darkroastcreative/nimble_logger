import 'package:nimble_logger/nimble_logger.dart';

void main() {
  NimbleLogger logger = NimbleLogger([LoggingMethod.console]);
  logger.setFileLoggingPath('C:\\Logs\\sampleOutput.log');
  logger.setFileLoggingState(true);
  logger.logMessage('Hello, world!');
}
