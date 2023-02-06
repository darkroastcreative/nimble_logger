import 'dart:io';

import 'package:nimble_logger/src/logging_method.dart';

class NimbleLogger {
  // Declare and initialize booleans tracking which logging methods are enabled.
  bool _isConsoleLoggingEnabled = false;
  bool _isFileLoggingEnabled = false;

  // Declare and initialize file logging path variable for file-based logging.
  String _fileLoggingPath = '';
  File? _logFile;

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

  void logMessage(String message) {
    String preparedMessage = '${DateTime.now()}\t$message';

    if (_isConsoleLoggingEnabled) {
      print(preparedMessage);
    }

    if (_isFileLoggingEnabled) {
      if (_logFile != null) {
        print('Logging to file.');
        try {
          IOSink? _ioSink = _logFile?.openWrite(mode: FileMode.append);

          _ioSink?.writeln(preparedMessage);

          _ioSink?.close();

          print('Logged to file.');
        } catch (exception) {
          if (_isConsoleLoggingEnabled) {
            print(
                '${DateTime.now()}\tERROR: Could not open IOSink to log to file.');
          }
        }
      }
    }
  }

  void logError(String message) {
    // TODO: Implement!
  }

  void setConsoleLoggingState(bool enabled) {
    _isConsoleLoggingEnabled = enabled;
  }

  void setFileLoggingState(bool enabled) {
    if (enabled) {
      _isFileLoggingEnabled = _testFileLoggingCapability();
    } else {
      _isFileLoggingEnabled = false;
    }
  }

  void setFileLoggingPath(String path) {
    _fileLoggingPath = path;
    _isFileLoggingEnabled = _testFileLoggingCapability();
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
