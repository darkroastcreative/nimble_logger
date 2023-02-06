# nimble_logger

A fast and lightweight logging library for Dart projects.

## Features

- Log messages and errors to console.
- Log messages and errors to file.

## Usage

```dart
import 'package:nimble_logger/nimble_logger.dart';
import 'package:nimble_logger/src/utility_functions.dart';

void main() {
    // Declare and initialize an instance of NimbleLogger with console logging
    // enabled.
    NimbleLogger logger = NimbleLogger([LoggingMethod.console]);

    // Set path for file-based logging.
    logger.setFileLoggingPath('/Users/david/Documents/Logs/TestLog ${getSanitizedTimestampString(DateTime.now())}.log');
    // Enable file-based logging.
    logger.setFileLoggingState(true);

    // Log a couple test messages to console and file.
    logger.logMessage('Hello, world!');
    logger.logError('On no!');

    // Log a test error by creating an exception and logging an error message
    // with an exception.
    try {
        throw Exception('Something went wrong.');
    } on Exception catch (exception) {
        logger.logError('Intentionally threw an exception to test logging errors with exceptions.', exception: exception);
    }
}
```
