part of 'chat_cubit.dart';

@immutable
class ChatState {
  final ChatModel? currentChat;
  final bool isLoading;

  const ChatState({
    this.currentChat,
    required this.isLoading,
  });

  List<ChatMessage> get messages => currentChat?.messages ?? [];

  ChatState copyWith({
    ChatModel? currentChat,
    bool? isLoading,
  }) {
    return ChatState(
      currentChat: currentChat ?? this.currentChat,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
