import 'package:flutter/material.dart';

// MessageBubble để hiển thị một tin nhắn trò chuyện trên ChatScreen.
class MessageBubble extends StatelessWidget {
  // Tạo bong bóng tin nhắn có nghĩa là bong bóng đầu tiên trong chuỗi.
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  // Tạo bong bóng tin nhắn tiếp tục chuỗi cùng user.
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  // Bong bóng tin nhắn này có phải là bong bóng đầu tiên trong chuỗi tin nhắn hay không
  // từ cùng một người dùng.
  // Sửa đổi bong bóng tin nhắn một chút cho các trường hợp khác nhau - chỉ
  // hiển thị hình ảnh người dùng cho tin nhắn đầu tiên từ cùng một người dùng và các thay đổi
  // hình dạng bong bóng cho các tin nhắn sau đó.
  final bool isFirstInSequence;

  // Hình ảnh của người dùng sẽ được hiển thị bên cạnh bong bóng chat.
  // Không bắt buộc nếu tin nhắn không phải là tin nhắn đầu tiên trong chuỗi.
  final String? userImage;

  // Username of the user.
  // Not required if the message is not the first in a sequence.
  final String? username;
  final String message;

  // Kiểm soát cách căn chỉnh MessageBubble.
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            // Căn chỉnh hình ảnh người dùng sang phải nếu tin nhắn là của tôi.
            right: isMe ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage!),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          ),
        Container(
          // Thêm một số lề vào các cạnh của tin nhắn, để có khoảng trống cho
          // hình ảnh của người dùng.
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            // Phía màn hình trò chuyện mà tin nhắn sẽ hiển thị.
            mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Tin nhắn đầu tiên trong chuỗi tin nhắn
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                      ),
                      child: Text(
                        username!,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  // Hộp "speech" bao quanh tin nhắn.
                  Container(
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.grey[300]
                          : theme.colorScheme.secondary.withAlpha(200),
                      // Chỉ hiển thị "speaking edge" của bong bóng tin nhắn nếu lần đầu tiên ở
                      // chuôi.
                      // "speaking edge" nằm bên trái hay bên phải tùy thuộc vào
                      // xem bong bóng tin nhắn có phải là người dùng hiện tại hay không.
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    // Đặt một số ràng buộc hợp lý về độ rộng của
                    // bong bóng tin nhắn để nó có thể điều chỉnh theo số lượng văn bản
                    // nó sẽ hiển thị.
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    // Margin around the bubble.
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        // Add a little line spacing to make the text look nicer
                        // when multilined.
                        height: 1.3,
                        color: isMe
                            ? Colors.black87
                            : theme.colorScheme.onSecondary,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}