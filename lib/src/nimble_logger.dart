import 'dart:io';

import 'package:nimble_logger/src/logging_method.dart';

class NimbleLogger {
  // Declare and initialize booleans tracking which logging methods are enabled.
  bool _isConsoleLoggingEnabled = false;
  bool _isFileLoggingEnabled = false;

  // Declare and initialize file logging path variable for file-based logging.
  String _fileLoggingPath = '';
  File? _logFile;

  /// Constructs a new instance of NimbleLogger.
  NimbleLogger(List<LoggingMethod> enabledLoggingMethods,
      {String fileLoggingPath = ''}) {
    if (enabledLoggingMethods.isNotEmpty) {
      // Set state of console-based logging based on presence of "console" in
      // enabled logging methods.
      _isConsoleLoggingEnabled =
          enabledLoggingMethods.contains(LoggingMethod.console);

      // Set state of file-based logging based on presence of "file" in enabled
      // logging methods and whether a file at the provided path can be opened
      // for writing.
      if (enabledLoggingMethods.contains(LoggingMethod.file) &&
          fileLoggingPath.isNotEmpty) {
        _fileLoggingPath = fileLoggingPath;

        _isFileLoggingEnabled = _testFileLoggingCapability();
      }
    }
  }

  /// Logs a given message through the enabled logging methods.
  void logMessage(String message) {
    // Build base log message.
    String preparedMessage = '${DateTime.now()}\t$message';

    // If console-based logging is enabled, proceed to log the provided message
    // to the console.
    if (_isConsoleLoggingEnabled) {
      print(preparedMessage);
    }

    // If file-based logging is enabled, proceed to log the provided message
    // to file.
    if (_isFileLoggingEnabled) {
      if (_logFile != null) {
        try {
          IOSink? _ioSink = _logFile?.openWrite(mode: FileMode.append);

          _ioSink?.writeln(preparedMessage);

          _ioSink?.close();
        } catch (exception) {
          if (_isConsoleLoggingEnabled) {
            print(
                '${DateTime.now()}\tERROR: Could not open IOSink to log to file.');
          }
        }
      }
    }
  }

  /// Logs a given error message through the enabled logging methods along with
  /// an Exception if provided.
  void logError(String message, {Exception? exception}) {
    // Build base log message.
    String preparedMessage = 'ERROR: $message';

    // If an Exception is provided, add it to the log message.
    if (exception != null) {
      preparedMessage = '$preparedMessage\n${exception.toString()}';
    }

    // Log out the constructed log message.
    logMessage(preparedMessage);
  }

  /// Sets whether console-based logging is enabled.
  void setConsoleLoggingState(bool enabled) {
    _isConsoleLoggingEnabled = enabled;
  }

  /// Sets whether file-based logging is enabled. If setting to true (thus
  /// enabling file-based logging), nimble_logger will confirm that file-based
  /// logging is possible with the given log file path.
  void setFileLoggingState(bool enabled) {
    if (enabled) {
      _isFileLoggingEnabled = _testFileLoggingCapability();
    } else {
      _isFileLoggingEnabled = false;
    }
  }

  /// Sets the path to use for file-based logging. If file-based logging is
  /// enabled at the time that this is called, it will re-verify that
  /// file-based logging is possible with the given path.
  void setFileLoggingPath(String path) {
    _fileLoggingPath = path;

    // If file-based logging is enabled, verify that file-based logging is
    // possible at the new path.
    if (_isFileLoggingEnabled) {
      _isFileLoggingEnabled = _testFileLoggingCapability();
    }
  }

  /// Tests whether nimble_logger is able to log to file at the specified file
  /// path. Returns true if the test was successful and false if the test failed.
  bool _testFileLoggingCapability() {
    bool fileLoggingTestSucceeded = false;

    // Try to open a file at the provided file logging path for writing and
    // set the state of file-based logging based on the outcome (enabled if
    // file could be opened successfully, disabled if not).
    if (_fileLoggingPath.isNotEmpty) {
      try {
        _logFile = File(_fileLoggingPath);

        if (_logFile != null) {
          IOSink? _ioSink = _logFile?.openWrite(mode: FileMode.append);

          fileLoggingTestSucceeded = _ioSink != null;

          _ioSink?.close();
        }
      } catch (exception) {
        if (_isConsoleLoggingEnabled) {
          print(
              '${DateTime.now()}\tERROR: Could not open IOSink to log to file.');
        }
      }
    }

    return fileLoggingTestSucceeded;
  }
}
