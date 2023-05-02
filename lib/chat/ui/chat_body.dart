import 'package:flutter/material.dart';

import '../model/model.dart';
import '../network/chat_repository.dart';
import '../utils/colors.dart';
import 'chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "YumBot",
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: ColorSets.botBackgroundColor,
      ),
      backgroundColor: ColorSets.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: ColorSets.botBackgroundColor,
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            setState(
              () {
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textController.text.toLowerCase();
            if (isInputRelatedTOFood(input)) {
              _textController.clear();
              Future.delayed(const Duration(milliseconds: 50))
                  .then((_) => _scrollDown());
              generateResponse(input).then((value) {
                setState(() {
                  isLoading = false;
                  _messages.add(
                    ChatMessage(
                      text: value,
                      chatMessageType: ChatMessageType.bot,
                    ),
                  );
                });
              });
            } else {
              setState(() {
                isLoading = false;
                _messages.add(
                  ChatMessage(
                    text: 'I am not meant for this',
                    chatMessageType: ChatMessageType.bot,
                  ),
                );
              });
            }
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
        ),
      ),
    );
  }

  bool isInputRelatedTOFood(String input) {
    final foodKeywords = ['food', 'meal', 'recipe','reciepe','history','appetizing',
'delicious','tasty','savory','sweet','spicy','favorful','yummy','nutritious',
'organic','fresh','cooked','cook','raw','meat','diary','milk','baked','grilled',
'fried','seasoned','pizza', 'sushi', 'burger', 'tacos', 'pasta', 'salad', 'ramen',
'kebab', 'croissant', 'curry', 'burrito', 'fajitas', 'risotto', 'paella', 'stir-fry',
'smoothie', 'falafel', 'crepes', 'hummus','quinoa','avocado', 'bacon', 'chicken', 'donut', 
'eggs', 'fries', 'grilled cheese', 'hot dog', 'jelly', 'ketchup', 'lemonade', 'mac and cheese',
 'nachos', 'oatmeal', 'peanut butter', 'queso', 'ribs', 'salsa', 'tuna', 'vanilla', 'whipped cream',
 'yogurt','ziti','asparagus', 'broccoli', 'cauliflower', 'dates', 'eggplant', 'figs', 'grapes', 'honeydew', 
 'jalapeno', 'kiwi', 'lentils', 'mango', 'nectarine', 'olives', 'pomegranate', 'quince', 'raspberries',
 'shallots', 'tangerine', 'urad dal', 'vadouvan', 'watercress', 'xigua', 'yellow squash',
 'zucchini flowers','french fries','burger','sambhar','rasam','idly','dosa','chutney','cone',
 'waffle','salmon','cavery',
];
    for (var keyword in foodKeywords) {
      if (input.contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: ColorSets.botBackgroundColor,
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
