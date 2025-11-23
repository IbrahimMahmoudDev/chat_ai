part of 'chat_cubit.dart';

@immutable
class ChatState {
  final ChatModel? currentChat;
  final bool isLoading;

  const ChatState({
    this.currentChat,
    required this.isLoading,
  });

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
