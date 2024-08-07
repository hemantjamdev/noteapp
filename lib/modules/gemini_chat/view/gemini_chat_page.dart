import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/model/chat_model.dart';
import 'package:note/modules/gemini_chat/cubit/gemini_chat_cubit.dart';

extension on BuildContext {
  GeminiChatCubit get cubit => read();
}

class GeminiChatPage extends StatelessWidget {
  GeminiChatPage({super.key});

  static Route route({required String data}) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider<GeminiChatCubit>(
        create: (context) => GeminiChatCubit(data: data),
        child: GeminiChatPage(),
      );
    });
  }

  final FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gemini Bot"),
        centerTitle: true,
      ),
      body: BlocBuilder<GeminiChatCubit, GeminiChatState>(
        buildWhen: (current, previous) =>
            current.chat != previous.chat ||
            current.isLoading != previous.isLoading,
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.chat.length,
                        itemBuilder: (context, int index) {
                          ChatModel chat = state.chat[index];
                          return Align(
                            alignment: chat.icCurrentUser
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                color: chat.icCurrentUser
                                    ? Color(0xffffa3a3)
                                    : Color(0xff7ecbff),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    chat.icCurrentUser ? 0 : 8,
                                  ),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  topRight: Radius.circular(
                                    chat.icCurrentUser ? 8 : 0,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Text(chat.message),
                            ),
                          );
                        }),
                  ),
                  TextField(
                    controller: _controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: "Chat with AI",
                      suffixIcon: GestureDetector(
                          onTap: () {
                            if (_controller.text.isEmpty) return;
                            context.cubit.sendMessage(_controller.text);
                            _controller.clear();
                            focusNode.unfocus();
                          },
                          child: Icon(Icons.send)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                    onChanged: (String value) {
                      if (value.isEmpty) {
                        focusNode.unfocus();
                      }
                    },
                    onSubmitted: (value) {
                      if (_controller.text.isEmpty) return;
                      context.cubit.sendMessage(_controller.text);
                      _controller.clear();
                      focusNode.unfocus();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
