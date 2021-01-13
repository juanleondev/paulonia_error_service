library paulonia_error_service;

import 'package:catcher/catcher.dart';
import 'package:paulonia_error_service/constants.dart';
import 'package:paulonia_utils/paulonia_utils.dart';
import 'package:sentry/sentry.dart';

class PauloniaErrorService {
  /// Send an error to Catcher
  ///
  /// This function has to be used to handle all errors in the app
  static void sendError(dynamic error) {
    try {
      throw (error);
    } catch (_error, stacktrace) {
      if (PUtils.isOnTest()) throw (error);
      Catcher.reportCheckedError(error, stacktrace);
    }
  }

  /// Get the configurations for Catcher
  ///
  /// This functions returns the configuration for debug, release and profile.
  /// This function sets [SilentReportMode()] and [ConsoleHandler()] in
  /// all configurations.
  ///
  /// Set [sentryDSN] to configure the [SentryHandler()] in release configuration
  static Map<String, CatcherOptions> getCatcherConfig({
    String sentryDSN,
  }) {
    final SentryClient _sentry =
        sentryDSN != null ? SentryClient(SentryOptions(dsn: sentryDSN)) : null;
    CatcherOptions debugOptions =
        CatcherOptions(SilentReportMode(), [ConsoleHandler()]);
    CatcherOptions releaseOptions = CatcherOptions(
        SilentReportMode(),
        _sentry == null
            ? [ConsoleHandler()]
            : [
                ConsoleHandler(),
                SentryHandler(_sentry),
              ]);
    CatcherOptions profileOptions =
        CatcherOptions(SilentReportMode(), [ConsoleHandler()]);
    return {
      CatcherConfig.DEBUG: debugOptions,
      CatcherConfig.RELEASE: releaseOptions,
      CatcherConfig.PROFILE: profileOptions,
    };
  }
}
