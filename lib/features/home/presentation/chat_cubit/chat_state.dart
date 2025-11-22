part of 'chat_cubit.dart';

@immutable
class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;

  const ChatState({required this.messages, required this.isLoading});

  ChatState copyWith({List<ChatMessage>? messages, bool? isLoading}) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
