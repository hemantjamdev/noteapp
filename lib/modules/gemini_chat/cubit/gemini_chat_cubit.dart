import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:note/model/chat_model.dart';

part 'gemini_chat_cubit.freezed.dart';
part 'gemini_chat_state.dart';

class GeminiChatCubit extends Cubit<GeminiChatState> {
  GeminiChatCubit({required String data}) : super(GeminiChatState()) {
    _customInstructions.add(data);
    emit(state.copyWith(noteData: _customInstructions.toString()));

    /// TODO : enable model init
    // initModel();
  }

  String apiKey = "AIzaSyC3OUAHi6rf-iLBNFmqMlK6H-bI4EmjbxQ";
  late final GenerativeModel model;

  initModel() {
    model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 64,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'text/plain',
      ),
      systemInstruction: Content.system(state.noteData.toString()),
    );
  }

  // initChat(String data) async {
  //   emit(state.copyWith(isLoading: true));
  //   final model = GenerativeModel(
  //     model: 'gemini-1.5-pro',
  //     apiKey: apiKey,
  //     generationConfig: GenerationConfig(
  //       temperature: 1,
  //       topK: 64,
  //       topP: 0.95,
  //       maxOutputTokens: 8192,
  //       responseMimeType: 'text/plain',
  //     ),
  //     systemInstruction: Content.system(state.noteData.toString()),
  //   );
  //
  //   final chat = model.startChat();
  //
  //   final message =
  //       "save this data for future conversation here is the notes data for user ${"hemant"}, ${data}";
  //   final content = Content.text(message);
  //
  //   final response = await chat.sendMessage(content);
  //
  //   emit(state.copyWith(isLoading: false));
  // }

  sendMessage(String input) async {
    if (input.isEmpty) return;

    final List<ChatModel> list = List.from(state.chat);
    list.add(ChatModel(message: input, icCurrentUser: true));
    emit(state.copyWith(chat: list, isLoading: true));
    late String? chatMessage;
    try {
      final chat = model.startChat(history: []);
      final message = input;
      final content = Content.text(message);

      final response = await chat.sendMessage(content);

      final List<ChatModel> chatList = List.from(state.chat);
      String? chatMessage = response.text?.replaceAll("**", "");
      chatList.add(ChatModel(
          message: chatMessage ?? "Error occurred", icCurrentUser: false));
      emit(state.copyWith(chat: chatList, isLoading: false));
    } catch (e) {
      final List<ChatModel> chatList = List.from(state.chat);
      chatMessage = "Error occurred";
      chatList.add(ChatModel(message: chatMessage, icCurrentUser: false));
      emit(state.copyWith(chat: chatList, isLoading: false));
    }
  }
}

List<String> _customInstructions = [
  "-Only provide answers related to the provided data.\n",
  "-Do not answer questions outside the provided data.\n",
  "-Keep responses under 500 keywords, making them as concise as possible.\n",
  "-Communicate in a friendly, human-like manner.\n",
  "-Retrieve specific answers without returning the entire dataset.\n",
  "-Use the provided data for responses.\n",
  "-Show human-friendly error messages if any errors occur.\n",
  "-Display friendly error messages for out-of-context questions.\n",
  "-Greet the user by name, if available.\n",
  "-Here is the list of note model data below : \n",
];
