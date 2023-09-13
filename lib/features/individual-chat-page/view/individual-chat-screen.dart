import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ok_edus/app/own-message-card.dart';
import 'package:ok_edus/app/reply-message-card.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/model/chat-history-model.dart';
import 'package:ok_edus/model/get-chat-model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class IndividualChatScreen extends StatefulWidget {
  IndividualChatScreen({super.key, required this.chatModel});
  final GetChatModel chatModel;

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  bool sendButton = false;
  String? message1;
  String? socketId;
  String? dateTime;
  String? dateTimeHistory;
  Map<String, dynamic>? jsonList;
  var text = TextEditingController();
  List<Map<String, dynamic>> mesages = [];
  List<String> dateTimeList = [];
  List<ChatHistoryModel> messagesHistory = [];
  var reversedItems;
  // late WebSocketChannel channel;
  final channel = WebSocketChannel.connect(
      Uri.parse('ws://mobile.mektep.edu.kz:6001/app/*%)35ke9Uw86*kWr'));
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startProcess();
    loadHistoryChat();
  }

  Future<void> startProcess() async {
    await takeCocket();
  }

  Future<void> takeCocket() async {
    await channel.stream.listen(
      (message) {
        Map<String, dynamic> decodedMessage = json.decode(message);
        if (decodedMessage['event'] == 'pusher:connection_established') {
          String dataString = decodedMessage['data'];
          Map<String, dynamic> data = json.decode(dataString);
          socketId = data['socket_id'];
          sMesages();
          print(socketId);
        } else if (decodedMessage['event'] == 'new_message') {
          String dataString = decodedMessage['data'];
          Map<String, dynamic> data = json.decode(dataString);
          final date = DateTime.parse(data['date']);
          String formattedDate = DateFormat('HH:mm').format(date);
          dateTime = formattedDate;
          mesages.add({
            'text': data['text'],
          });
          reversedItems.insert(0, {
            'text': data['text'],
            'is_my': false,
            'date': '${DateTime.now()}'
          });
          print(reversedItems);
          setState(() {
            //dateTimeList.add(dateTime!);
          });

          print(dateTimeList);
          print(mesages.length);
        } else {
          print(decodedMessage);
        }
      },
    );
  }

  String getTime(String time) {
    final date = DateTime.parse(time);
    String formattedDate = DateFormat('HH:mm').format(date);
    return formattedDate;
  }

  Future<void> sendMessage() async {
    Map<String, dynamic> m = {"event": "pusher:subscribe", "data": jsonList};
    final jsonString = jsonEncode(m);

    print(jsonEncode(m));
    channel.sink.add(jsonString);
  }

  Future<Map<String, dynamic>> sMesages() async {
    var scopedToken = await SubjectsService.getToken();

    try {
      final response = await SubjectsService.fetchSendMessageToWebSocket(
          '${widget.chatModel.channelId}', '$socketId', '$scopedToken');

      Map<String, dynamic> responseData = response.data;
      jsonList = responseData;
      //print(jsonList);
      jsonList!['channel'] = "presence-chat.${widget.chatModel.channelId}";
      print(jsonList);
      sendMessage();
      return responseData; // Возвращаем JSON-данные вместо response
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          //Text('data');
          print('Request failed with status code: ${e.response!.statusCode}');
        }
      }
      throw e; // Пробрасываем ошибку дальше
    }
  }

  Future<Map<String, dynamic>> chatHistoryApi() async {
    var scopedToken = await SubjectsService.getToken();

    try {
      final response = await SubjectsService.fetchChatHistoryPost(
          '${widget.chatModel.channelId}', '$scopedToken');
      var responseData = jsonDecode(response.toString());
      // print(responseData);
      for (Map<String, dynamic> index in responseData['messages_list']) {
        // print(index);
        messagesHistory.add(ChatHistoryModel.fromJson(index));
      }
      // print(messagesHistory);
      for (var item in messagesHistory) {
        Map<String, dynamic> selectedItems = {
          'text': item.text,
          'is_my': item.isMy,
          'date': item.date
        };
        mesages.add(selectedItems);
        reversedItems = mesages.reversed.toList();
        // print(reversedItems);
      }
      setState(() {});

      return responseData; // Возвращаем JSON-данные вместо response
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          //Text('data');
          print('Request failed with status code: ${e.response!.statusCode}');
        }
      }
      print(e);
      throw e; // Пробрасываем ошибку дальше
    }
  }

  void loadHistoryChat() {
    chatHistoryApi();
  }

  Future<void> chatSendMessage(String text) async {
    var scopedToken = await SubjectsService.getToken();

    try {
      final response = await SubjectsService.fetchSendMessageToPerson(
          '${widget.chatModel.channelId}', text, '$scopedToken');
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          //Text('data');
          print('Request failed with status code: ${e.response!.statusCode}');
        }
      }
      throw e; // Пробрасываем ошибку дальше
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.blue,
          ),
          backgroundColor: Colors.white.withOpacity(0.800000011920929),
          title: Text(
            widget.chatModel.username,
            style: TextStyle(
              color: Color(0xFF1F2024),
              fontSize: 18,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
            ),
          )),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment(0.74, -0.67),
            end: Alignment(-0.74, 0.67),
            colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
          )),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Container(
                  height: MediaQuery.of(context).size.height - 180,
                  child:
                      //print(mesages);
                      ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: mesages.length,
                    itemBuilder: (context, index) {
                      return (reversedItems[index]['is_my'] == true)
                          ? OwnMessageCard(
                              message: reversedItems[index]['text'],
                              time: getTime('${reversedItems[index]['date']}'),
                            )
                          : ReplyCard(
                              message: reversedItems[index]['text'],
                              time: getTime('${reversedItems[index]['date']}'));
                    },
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 65,
                      child: Card(
                        // margin: EdgeInsets.only(left: 5, right: 2, bottom: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: text,
                          onChanged: (value) {
                            if (value.length > 0) {
                              setState(() {
                                sendButton = true;
                              });
                            } else {
                              setState(() {
                                sendButton = false;
                              });
                            }
                          },
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 12),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      child: IconButton(
                        icon: Icon(sendButton ? Icons.send : Icons.mic),
                        onPressed: () {
                          chatSendMessage(text.text);
                          mesages.add({
                            'text': text.text,
                            'is_my': true,
                            'date': '${DateTime.now()}'
                          });
                          reversedItems.insert(0, {
                            'text': text.text,
                            'is_my': true,
                            'date': '${DateTime.now()}'
                          });
                          text.clear();
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
