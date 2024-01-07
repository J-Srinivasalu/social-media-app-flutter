class ChatEventEnum {
  static const String CONNECTED_EVENT = 'connected';
  static const String DISCONNECT_EVENT = 'disconnect';
  static const String JOIN_CHAT_EVENT = 'joinChat';
  static const String MESSAGE_RECEIVED_EVENT = 'messageReceived';
  static const String NEW_CHAT_EVENT = 'newChat';
  static const String SOCKET_ERROR_EVENT = 'socketError';
  static const String STOP_TYPING_EVENT = 'stopTyping';
  static const String TYPING_EVENT = 'typing';
  static const String CHAT_MESSAGES_SEEN_EVENT = 'messagesSeen';
  static const String MESSAGE_DELIVERED = 'messageDelivered';
  static const String USER_ONLINE_EVENT = 'userOnline';
  static const String USER_OFFLINE_EVENT = 'userOffline';
}

class MessageStatus {
  static const String sending = 'sending';
  static const String sent = 'sent';
  static const String delivered = "delivered";
  static const String seen = "seen";
}
