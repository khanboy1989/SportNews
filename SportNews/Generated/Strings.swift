// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Details
  internal static let details = L10n.tr("Localizable", "details")
  /// Esports
  internal static let esports = L10n.tr("Localizable", "esports")
  /// Fussball
  internal static let football = L10n.tr("Localizable", "football")
  /// Motor Sport
  internal static let motorsport = L10n.tr("Localizable", "motorsport")
  /// News
  internal static let news = L10n.tr("Localizable", "news")
  /// Selected item cannot be displayed at this time please try later again.
  internal static let selectedItemError = L10n.tr("Localizable", "selectedItemError")
  /// Sport Mix
  internal static let sportmix = L10n.tr("Localizable", "sportmix")
  /// Winter Sport
  internal static let winterSport = L10n.tr("Localizable", "winterSport")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
