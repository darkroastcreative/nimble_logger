import 'package:nimble_logger/nimble_logger.dart';

class NimbleLogger {
  // Declare and initialize booleans tracking which logging methods are enabled.
  bool _isConsoleLoggingEnabled = false;
  bool _isFileLoggingEnabled = false;
  bool _isSqlServerLoggingEnabled = false;
  bool _isMySqlLoggingEnabled = false;

  // Declare and initialize file logging path variable for file-based logging.
  String _fileLoggingPath = '';

  // Declare and initialize variables used to track connection string components for SQL Server-based logging.
  String _sqlServerLoggingServer = '';
  int _sqlServerLoggingPort = 1433;
  String _sqlServerLoggingUsername = '';
  String _sqlServerLoggingPassword = '';

  // Declare and initialize variables used to track connection string components for MySQL-based logging.
  String _mySqlLoggingServer = '';
  int _mySqlLoggingPort = 1433;
  String _mySqlLoggingUsername = '';
  String _mySqlLoggingPassword = '';

  NimbleLogger(List<LoggingMethod> enabledLoggingMethods,
      {String fileLoggingPath = '',
      String sqlServerLoggingServer = '',
      int sqlServerLoggingPort = 1433,
      String sqlServerLoggingUsername = '',
      String sqlServerLoggingPassword = '',
      String mySqlLoggingServer = '',
      int mySqlLoggingPort = 1433,
      String mySqlLoggingUsername = '',
      String mySqlLoggingPassword = ''}) {
    if (enabledLoggingMethods.isNotEmpty) {
      if (enabledLoggingMethods.contains(LoggingMethod.console)) {
        _isConsoleLoggingEnabled = true;
      }

      if (enabledLoggingMethods.contains(LoggingMethod.file) &&
          fileLoggingPath.isNotEmpty) {
        _isFileLoggingEnabled = true;
        _fileLoggingPath = fileLoggingPath;
      }

      if (enabledLoggingMethods.contains(LoggingMethod.sqlserver) &&
          sqlServerLoggingServer.isNotEmpty &&
          sqlServerLoggingUsername.isNotEmpty &&
          sqlServerLoggingPassword.isNotEmpty) {
        _isSqlServerLoggingEnabled = true;
        _sqlServerLoggingServer = sqlServerLoggingServer;
        _sqlServerLoggingUsername = sqlServerLoggingUsername;
        _sqlServerLoggingPassword = sqlServerLoggingPassword;

        if (sqlServerLoggingPort != 1433) {
          _sqlServerLoggingPort = sqlServerLoggingPort;
        }
      }

      if (enabledLoggingMethods.contains(LoggingMethod.mysql) &&
          mySqlLoggingServer.isNotEmpty &&
          mySqlLoggingUsername.isNotEmpty &&
          mySqlLoggingPassword.isNotEmpty) {
        _isMySqlLoggingEnabled = true;
        _mySqlLoggingServer = mySqlLoggingServer;
        _mySqlLoggingUsername = mySqlLoggingUsername;
        _mySqlLoggingPassword = mySqlLoggingPassword;

        if (mySqlLoggingPort != 1433) {
          _mySqlLoggingPort = mySqlLoggingPort;
        }
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

    if(_isSqlServerLoggingEnabled && _isSqlServerLogging)
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

  void setSqlServerLoggingState(bool enabled) {
    _isSqlServerLoggingEnabled = enabled;
  }

  void setMySqlLoggingState(bool enabled) {
    _isMySqlLoggingEnabled = enabled;
  }

  void setFileLoggingPath(String path) {
    _fileLoggingPath = path;
  }
}
