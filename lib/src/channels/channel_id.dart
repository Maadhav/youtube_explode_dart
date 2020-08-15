import 'package:equatable/equatable.dart';

import '../extensions/helpers_extension.dart';

/// Encapsulates a valid YouTube channel ID.
class ChannelId with EquatableMixin {
  /// ID as a string.
  final String value;

  /// Initializes an instance of [ChannelId]
  ChannelId(String value) : value = parseChannelId(value);

  /// Returns true if the given id is a valid channel id.
  static bool validateChannelId(String id) {
    if (id.isNullOrWhiteSpace) {
      return false;
    }

    if (!id.startsWith('UC')) {
      return false;
    }

    if (id.length != 24) {
      return false;
    }

    return !RegExp(r'[^0-9a-zA-Z_\-]').hasMatch(id);
  }

  /// Parses a channel id from an url.
  /// Throws an argument error if the channel is not found
  static String parseChannelId(String url) {
    if (url.isWhitespace) {
      throw ArgumentError.value(url, 'url', 'Invalid channel id');
    }

    if (validateChannelId(url)) {
      return url;
    }

    var regMatch = RegExp(r'youtube\..+?/channel/(.*?)(?:\?|&|/|$)')
        .firstMatch(url)
        ?.group(1);
    if (!regMatch?.isNullOrWhiteSpace && validateChannelId(regMatch)) {
      return regMatch;
    }
    throw ArgumentError.value(url, 'url', 'Invalid channel id');
  }

  ///  Converts [obj] to a [ChannelId] by calling .toString on that object.
  /// If it is already a [ChannelId], [obj] is returned
  factory ChannelId.fromString(dynamic obj) {
    if (obj is ChannelId) {
      return obj;
    }
    return ChannelId(obj.toString());
  }

  @override
  String toString() => value;

  @override
  List<Object> get props => [value];
}
