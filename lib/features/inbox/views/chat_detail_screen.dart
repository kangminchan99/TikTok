import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/repos/autentication_repo.dart';
import 'package:tiktok/features/inbox/view_models/messages_view_model.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = 'chatDetail';
  // 자식 경로는 /로 시작할 수 없음
  static const String routeURL = ':chatId';
  final String chatId;
  const ChatDetailScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatDetailScreen> createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _textController = TextEditingController();

  void _onSendPress() {
    final text = _textController.text;
    if (text == '') return;

    ref.read(messagesProvider.notifier).sendMessage(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isLooading = ref.watch(messagesProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/114412280?v=4',
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.white, width: 2),

                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            '민찬 ${widget.chatId}',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.flag, size: Sizes.size20),
              Gaps.h32,
              FaIcon(FontAwesomeIcons.ellipsis, size: Sizes.size20),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ref
              .watch(chatProvider)
              .when(
                data: (data) {
                  return ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom:
                          MediaQuery.of(context).padding.bottom + Sizes.size96,
                      left: Sizes.size14,
                      right: Sizes.size14,
                    ),
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine =
                          message.userId == ref.read(authRepo).user!.uid;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(Sizes.size14),
                            decoration: BoxDecoration(
                              color: isMine
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Sizes.size20),
                                topRight: Radius.circular(Sizes.size20),
                                bottomLeft: Radius.circular(
                                  isMine ? Sizes.size20 : Sizes.size5,
                                ),
                                bottomRight: Radius.circular(
                                  isMine ? Sizes.size5 : Sizes.size20,
                                ),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: TextStyle(
                                color: isMine ? Colors.white : Colors.black,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Sizes.size44,
                      child: TextField(
                        controller: _textController,
                        textInputAction: TextInputAction.newline,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        decoration: InputDecoration(
                          hintText: 'Send a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size12),
                            borderSide: BorderSide.none,
                          ),

                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Sizes.size10,
                          ),

                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: Sizes.size10),
                            child: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: Colors.grey.shade900,
                            ),
                          ),
                          suffixIconConstraints: BoxConstraints(),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  GestureDetector(
                    onTap: _onSendPress,
                    child: Container(
                      child: FaIcon(
                        isLooading
                            ? FontAwesomeIcons.hourglass
                            : FontAwesomeIcons.paperPlane,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
