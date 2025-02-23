import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/features/message/message_page.dart';

import '../../../common/models/message.dart';


part 'message_event.dart';
part 'message_state.dart';

class MessageNotifier extends StateNotifier<MessageState> {
  MessageNotifier() : super(const MessageState()) {
  }

  void onMessageChanged(
      MessageChanged event,
      ) {

    state = state.copyWith(message: event.message);
  }
  void onLoadStatusChanged(
      LoadStatusChanged event,
      ) {
    state = state.copyWith(loadStatus: event.loadStatus);
  }

}
final messageProvider = StateNotifierProvider<MessageNotifier, MessageState>((ref) {
  return MessageNotifier();
});
