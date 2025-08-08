import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart' as di;
import '../../domain/usecases/get_chat_messages_usecase.dart';
import '../../domain/usecases/user_usecase.dart';
import '../../presentation/bloc/user_bloc/user_bloc.dart';
import '../../presentation/bloc/user_bloc/user_event.dart';
import '../../presentation/bloc/user_bloc/user_state.dart';
import '../bloc/chat_screen_bloc/chat_bloc.dart';
import '../bloc/chat_screen_bloc/chat_event.dart';
import '../bloc/chat_screen_bloc/chat_state.dart';
import '../bloc/message_bloc/message_bloc.dart';
import 'chat_detail_page.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final GetCurrentUser getCurrentUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatBloc()..add(const LoadChats())),
        BlocProvider(
          create:
              (context) =>
                  UserBloc(getCurrentUser: di.sl<GetCurrentUser>())
                    ..add(const GetCurrentUserEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          leading: IconButton(
            
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Chats', style: TextStyle(color: Colors.white)),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<ChatBloc>().add(const RefreshChats());
            context.read<UserBloc>().add(const GetCurrentUserEvent());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: [
                  Container(
                    height: 110,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return BlocBuilder<UserBloc, UserState>(
                            builder: (context, userState) {
                              if (userState is UserLoaded) {
                                return Container(
                                  width: 65,
                                  height: 95,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 28,
                                            backgroundColor: Colors.blueAccent,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.pinkAccent,
                                              child: Text(
                                                userState.user.initials,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                                border: Border.fromBorderSide(
                                                  BorderSide(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        userState.user.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return Container(
                                width: 65,
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        const CircleAvatar(
                                          radius: 28,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.purpleAccent,
                                            size: 28,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                              border: Border.fromBorderSide(
                                                BorderSide(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          final storyIndex = index - 1;
                          return Container(
                            width: 65,
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 26,
                                        backgroundColor: _getRandomColor(
                                          storyIndex,
                                        ),
                                        child: Text(
                                          _getInitials(storyIndex),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _getFirstName(storyIndex),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent Chats",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Icon(Icons.more_vert, color: Colors.grey),
                            ],
                          ),
                        ),

                        BlocBuilder<ChatBloc, ChatState>(
                          builder: (context, state) {
                            if (state is ChatLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(50.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              );
                            }

                            if (state is ChatError) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 60,
                                      color: Colors.red[300],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      state.message,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<ChatBloc>().add(
                                          const LoadChats(),
                                        );
                                      },
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (state is ChatLoaded) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.chats.length,
                                itemBuilder: (context, index) {
                                  final chat = state.chats[index];
                                  final otherUser =
                                      chat.user1.name == 'Me'
                                          ? chat.user2
                                          : chat.user1;

                                  return ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                    leading: CircleAvatar(
                                      radius: 28,
                                      backgroundColor: _getRandomColor(index),
                                      child: Text(
                                        _getInitialsFromName(otherUser.name),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      otherUser.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    subtitle: Text(
                                      otherUser.email,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          _getTime(index),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        if (index % 3 == 0)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (
                                                context,
                                              ) => BlocProvider<MessageBloc>(
                                                create:
                                                    (context) => MessageBloc(
                                                      getChatMessages:
                                                          di
                                                              .sl<
                                                                GetChatMessages
                                                              >(),
                                                    ),
                                                child: ChatDetailPage(
                                                  userName: otherUser.name,
                                                  userInitials:
                                                      _getInitialsFromName(
                                                        otherUser.name,
                                                      ),
                                                  userColor: _getRandomColor(
                                                    index,
                                                  ),
                                                  chatId: chat.id,
                                                ),
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }

                            return const Padding(
                              padding: EdgeInsets.all(50.0),
                              child: Center(child: Text('No chats available')),
                            );
                          },
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getInitialsFromName(String name) {
    final nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return name.length >= 2
        ? name.substring(0, 2).toUpperCase()
        : name[0].toUpperCase();
  }

  Color _getRandomColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    return colors[index % colors.length];
  }

  String _getInitials(int index) {
    final names = ['JD', 'AS', 'MK', 'LB', 'RT', 'SG', 'NK', 'DP'];
    return names[index % names.length];
  }

  String _getFirstName(int index) {
    final names = [
      'John',
      'Alice',
      'Mike',
      'Lisa',
      'Robert',
      'Sarah',
      'Nick',
      'Diana',
    ];
    return names[index % names.length];
  }

  String _getTime(int index) {
    final times = [
      '09:15 AM',
      '10:30 AM',
      'Yesterday',
      '08:45 PM',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
    ];
    return times[index % times.length];
  }
}
