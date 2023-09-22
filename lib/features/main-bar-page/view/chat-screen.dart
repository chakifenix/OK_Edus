import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/features/individual-chat-page/view/individual-chat-screen.dart';
import 'package:ok_edus/model/chat-model.dart';
import 'package:ok_edus/model/get-chat-model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<GetChatModel> chats1 = [];
  List<GetChatModel> result = [];
  List wrong = [];
  TextEditingController controller = TextEditingController();

  Future<List<GetChatModel>> getChats() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    final response = await SubjectsService.fetchSubjects(
        '${lang}/messenger/get-chats', '$scopedToken');
    var data = jsonDecode(response.toString());

    if (response.statusCode == 200) {
      setState(() {
        for (Map<String, dynamic> index in data['chat_list']) {
          chats1.add(GetChatModel.fromJson(index));
        }
      });

      return chats1;
    } else {
      return chats1;
    }
  }

  updateTextField(String text) async {
    result.clear();
    wrong.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    chats1.forEach((element) {
      List<String> words = element.username.toLowerCase().split(' ');
      print(words);
      for (String word in words) {
        if (word.startsWith(text)) {
          result.add(element);
        }
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Мессенджер',
            style: TextStyle(
              color: Color(0xFF1F2024),
              fontSize: 20,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: (chats1.length != 0)
            ? Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 14, left: 14, right: 14),
                    child: TextField(
                      onChanged: (value) => updateTextField(value),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                          hintText: 'search'.tr(),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Colors.grey),
                    ),
                  ),
                  Expanded(
                      child: result.length == 0 && wrong.length == 0
                          ? ListView.builder(
                              // padding: EdgeInsets.only(bottom: 20),
                              itemCount: chats1.length,
                              itemBuilder: (context, index) {
                                return CustomCard(chatModel: chats1[index]);
                              },
                              // separatorBuilder: (context, index) => SizedBox(
                              //   height: 0,
                              // ),
                            )
                          : ListView.builder(
                              // padding: EdgeInsets.only(bottom: 20),
                              itemCount: result.length,
                              itemBuilder: (context, index) {
                                return CustomCard(chatModel: result[index]);
                              },
                              // separatorBuilder: (context, index) => SizedBox(
                              //   height: 0,
                              // ),
                            )),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.chatModel,
  });

  final GetChatModel chatModel;

  String getTime(String time) {
    final date = DateTime.parse(time);
    return '${date.hour}:${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualChatScreen(
                      chatModel: chatModel,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 9, right: 9, top: 10),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.8199999928474426),
          ),
          child: ListTile(
            // onTap: () {},
            title: Text(chatModel.username),
            subtitle: Text(chatModel.message),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(image: AssetImage('images/girl1.png')),
              ),
            ),
            trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(getTime('${chatModel.date}')),
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100)),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
