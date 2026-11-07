import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:resto_qr/Core/Utils/app_localiztion.dart';

abstract class AppException implements Exception {
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppException({this.originalError, this.stackTrace});

  String get title;

  String get message;

  @override
  String toString() => '$title: $message';
}

class SupabaseAuthException extends AppException {
  SupabaseAuthException(dynamic originalError)
    : super(originalError: originalError);

  @override
  String get title => AppLocalization.current.authenticationError;

  @override
  String get message {
    final errorString = originalError.toString().toLowerCase();

    if (errorString.contains('invalid login credentials')) {
      return AppLocalization.current.incorrectCredentials;
    } else if (errorString.contains('user not found')) {
      return AppLocalization.current.accountNotFound;
    } else if (errorString.contains('email not confirmed')) {
      return AppLocalization.current.emailNotConfirmed;
    } else if (errorString.contains('password is too short')) {
      return AppLocalization.current.passwordTooShort;
    } else if (errorString.contains('network request failed')) {
      return AppLocalization.current.checkInternetConnection;
    } else if (errorString.contains('user already registered')) {
      return AppLocalization.current.emailAlreadyRegistered;
    }

    return AppLocalization.current.signInFailed;
  }
}

class SupabaseDBException extends AppException {
  SupabaseDBException(dynamic originalError)
    : super(originalError: originalError);

  @override
  String get title => AppLocalization.current.dataError;

  @override
  String get message {
    final errorString = originalError.toString().toLowerCase();

    if (errorString.contains('23505') ||
        errorString.contains('duplicate key')) {
      return AppLocalization.current.recordAlreadyExists;
    } else if (errorString.contains('23503') ||
        errorString.contains('foreign key constraint')) {
      return AppLocalization.current.missingRelatedData;
    } else if (errorString.contains('42501') ||
        errorString.contains('permission denied')) {
      return AppLocalization.current.permissionDenied;
    } else if (errorString.contains('timeout')) {
      return AppLocalization.current.serverTimeout;
    }

    return AppLocalization.current.saveDataFailed;
  }
}

class SupabaseRPCException extends AppException {
  SupabaseRPCException(dynamic originalError)
    : super(originalError: originalError);

  @override
  String get title => AppLocalization.current.procedureError;

  @override
  String get message {
    final errorString = originalError.toString().toLowerCase();

    if (errorString.contains('insufficient_funds')) {
      return AppLocalization.current.insufficientFunds;
    } else if (errorString.contains('invalid_state')) {
      return AppLocalization.current.invalidOperationState;
    } else if (errorString.contains('42883') ||
        errorString.contains('function does not exist')) {
      return AppLocalization.current.serverFunctionNotFound;
    } else if (errorString.contains('42501') ||
        errorString.contains('permission denied')) {
      return AppLocalization.current.procedurePermissionDenied;
    } else if (errorString.contains('timeout')) {
      return AppLocalization.current.backgroundProcessTimeout;
    }

    return AppLocalization.current.procedureExecutionFailed;
  }
}

class SupabaseStorageException extends AppException {
  SupabaseStorageException(dynamic originalError)
    : super(originalError: originalError);

  @override
  String get title => AppLocalization.current.uploadError;

  @override
  String get message {
    final errorString = originalError.toString().toLowerCase();

    if (errorString.contains('object not found')) {
      return AppLocalization.current.fileNotFound;
    } else if (errorString.contains('payload too large')) {
      return AppLocalization.current.fileTooLarge;
    } else if (errorString.contains('unsupported media type')) {
      return AppLocalization.current.unsupportedFileFormat;
    }

    return AppLocalization.current.fileUploadFailed;
  }
}

class SupabaseFunctionException extends AppException {
  SupabaseFunctionException(dynamic originalError)
    : super(originalError: originalError);

  @override
  String get title => AppLocalization.current.systemError;

  @override
  String get message {
    final errorString = originalError.toString().toLowerCase();

    if (errorString.contains('function_not_found')) {
      return AppLocalization.current.serviceUnavailable;
    } else if (errorString.contains('timeout')) {
      return AppLocalization.current.operationTimeout;
    } else if (errorString.contains('500')) {
      return AppLocalization.current.serverTrouble;
    }

    return AppLocalization.current.requestProcessingFailed;
  }
}

class NetworkException extends AppException {
  NetworkException(dynamic originalError) : super(originalError: originalError);

  @override
  String get title => AppLocalization.current.connectionError;

  @override
  String get message {
    return AppLocalization.current.serverUnreachable;
  }
}

class TimeoutException extends AppException {
  TimeoutException(dynamic originalError) : super(originalError: originalError);

  @override
  String get title => AppLocalization.current.requestTimedOut;

  @override
  String get message {
    return AppLocalization.current.requestTooSlow;
  }
}

class UnknownException extends AppException {
  UnknownException({
    super.originalError,
    super.stackTrace,
    this.errorDetails,
  });

  final String? errorDetails;

  @override
  String get title => AppLocalization.current.unexpectedError;

  @override
  String get message {
    return errorDetails ?? AppLocalization.current.unexpectedErrorDescription;
  }
}

class ExceptionHandler {
  static AppException handle({
    required dynamic error,
    required StackTrace stackTrace,
    String? errorDetails,
    bool isRpc = false,
  }) {
    // log(stackTrace.toString());
    if (error is SocketException) {
      return NetworkException(error);
    }
    if (error is TimeoutException) {
      return TimeoutException(error);
    }

    if (error is AuthException) {
      return SupabaseAuthException(error);
    }

    if (error is PostgrestException) {
      if (isRpc) {
        return SupabaseRPCException(error);
      }
      return SupabaseDBException(error);
    }

    if (error is StorageException) {
      return SupabaseStorageException(error);
    }
    if (error is FunctionException) {
      return SupabaseFunctionException(error);
    }

    return UnknownException(
      originalError: error,
      stackTrace: stackTrace,
      errorDetails: errorDetails,
    );
  }
}
