import 'package:nimble_logger/nimble_logger.dart';

class NimbleLogger {
  // Declare and initialize booleans tracking which logging methods are enabled.
  bool _isConsoleLoggingEnabled = false;
  bool _isFileLoggingEnabled = false;

  // Declare and initialize file logging path variable for file-based logging.
  String _fileLoggingPath = '';

  NimbleLogger(List<LoggingMethod> enabledLoggingMethods,
      {String fileLoggingPath = ''}) {
    if (enabledLoggingMethods.isNotEmpty) {
      if (enabledLoggingMethods.contains(LoggingMethod.console)) {
        _isConsoleLoggingEnabled = true;
      }

      if (enabledLoggingMethods.contains(LoggingMethod.file) &&
          fileLoggingPath.isNotEmpty) {
        _isFileLoggingEnabled = true;
        _fileLoggingPath = fileLoggingPath;
      }
    }
  }

  void logMessage(String message) {
    String preparedMessage = '${DateTime.now()}\t$message';

    if (_isConsoleLoggingEnabled) {
      print(preparedMessage);
    }

    if (_isFileLoggingEnabled && _isFileLoggingFunctional) {
      // TODO: Implement!
    }
  }

  void logError(String message) {
    // TODO: Implement!
  }

  void setConsoleLoggingState(bool enabled) {
    _isConsoleLoggingEnabled = enabled;
  }

  void setFileLoggingState(bool enabled) {
    _isFileLoggingEnabled = enabled;
  }

  void setFileLoggingPath(String path) {
    _fileLoggingPath = path;
  }
}
