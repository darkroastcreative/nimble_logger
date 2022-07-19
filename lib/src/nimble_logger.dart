import 'package:nimble_logger/nimble_logger.dart';

class NimbleLogger {
  bool _isConsoleLoggingEnabled = false;
  bool _isFileLoggingEnabled = false;

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

    if (_isFileLoggingEnabled && _fileLoggingPath.isNotEmpty) {
      // TODO: Implement!
    }
  }

  void logError(String message) {
    // TODO: Implement!
  }

  void setConsoleLoggingState(bool enabled) {
    _isConsoleLoggingEnabled = enabled;
  }

  void setFileLoggingPath(String path) {
    _fileLoggingPath = path;
  }

  void setFileLoggingState(bool enabled) {
    _isFileLoggingEnabled = enabled;
  }
}
