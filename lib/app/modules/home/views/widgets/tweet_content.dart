part of 'tweet_item.dart';

Column tweetContent(height, context, controller, document, data) {
  return Column(children: [
    SizedBox(
      height: height(5.0),
    ),
    Visibility(
        visible: controller.editId.value != document.reference.id,
        child: Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: '${data['content']}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            )),
        replacement: Align(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              textInputAction: TextInputAction.send,
              onChanged: (val) => controller.setEdit(document.reference, val),
              initialValue: data['content'],
              onFieldSubmitted: (val) {
                controller.updateTweet(document.reference);
              },
              minLines: 7,
              maxLines: 7,
              maxLength: 280,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ))),
    footerButtons(controller, document, data)
  ]);
}
