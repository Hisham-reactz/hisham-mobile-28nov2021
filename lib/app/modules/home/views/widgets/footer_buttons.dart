part of 'tweet_item.dart';

Visibility footerButtons(controller, document, data) {
  return Visibility(
      visible: controller.editId.value != document.reference.id,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
              child: TextButton.icon(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  onPressed: null,
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                  label: const Text(
                    '7',
                    style: TextStyle(fontSize: 12),
                  ))),
          Flexible(
              child: TextButton.icon(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  onPressed: null,
                  icon: const Icon(
                    Icons.repeat,
                  ),
                  label: const Text(
                    '5',
                    style: TextStyle(fontSize: 12),
                  ))),
          Flexible(
              child: TextButton.icon(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  onPressed: null,
                  icon: const Icon(
                    Icons.favorite_outline,
                  ),
                  label: const Text(
                    '13',
                    style: TextStyle(fontSize: 12),
                  ))),
          Expanded(
              child: Visibility(
                  visible: controller.userId == data['user_id'],
                  child: TextButton.icon(
                      key: const ValueKey('editTweetButton'),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero)),
                      onPressed: () =>
                          controller.setEdit(document.reference, ''),
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.lightBlue,
                      ),
                      label: const Text(
                        '',
                        style: TextStyle(fontSize: 12),
                      )),
                  replacement: const SizedBox.shrink())),
        ],
      ));
}
