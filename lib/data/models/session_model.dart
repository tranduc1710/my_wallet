import 'package:base_flutter/domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshExpiresIn = json['refresh_expires_in'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    notBeforePolicy = json['not-before-policy'];
    sessionState = json['session_state'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['refresh_expires_in'] = refreshExpiresIn;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['not-before-policy'] = notBeforePolicy;
    data['session_state'] = sessionState;
    data['scope'] = scope;
    return data;
  }
}
