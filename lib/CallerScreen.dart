// ignore_for_file: file_names

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/material.dart';

class CallerScreen extends StatefulWidget {
  const CallerScreen({super.key});

  @override
  CallerScreenState createState() => CallerScreenState();
}

class CallerScreenState extends State<CallerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String phoneNumber = '';

  void _makePhoneCall() async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    if (res != null && res) {
      // Call was successful
      print('Call initiated successfully');
    } else {
      // Call failed
      print('Failed to initiate call');
    }
  }

  void _addNumber(String digit) {
    setState(() {
      phoneNumber += digit;
    });
  }

  void _deleteNumber() {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone'),
        /* backgroundColor: const Color.fromARGB(255, 40, 127, 197),
        foregroundColor: Colors.white, */
      ),
      body: Column(
        children: [
          TabBar(
            indicatorColor: const Color.fromARGB(255, 40, 127, 197),
            labelColor: const Color.fromARGB(255, 40, 127, 197),
            controller: _tabController,
            tabs: const [
              Tooltip(
                message: 'Here Recents Calls are showed',
                child: Tab(text: 'Recent Calls'),
              ),
              Tooltip(
                message:
                    'Here Dailer are showed\nWhere we can dail the number to call',
                child: Tab(text: 'Dialer'),
              ),
              Tooltip(
                message: 'Here Contacts are showed',
                child: Tab(text: 'Contacts'),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const Center(child: Text('Recent Calls')),
                _buildDialer(),
                const Center(child: Text('Contacts')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialer() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  phoneNumber,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DialerButton(
                      digit: '1',
                      onPressed: () => _addNumber('1'),
                    ),
                    DialerButton(
                      digit: '2',
                      onPressed: () => _addNumber('2'),
                    ),
                    DialerButton(
                      digit: '3',
                      onPressed: () => _addNumber('3'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DialerButton(
                      digit: '4',
                      onPressed: () => _addNumber('4'),
                    ),
                    DialerButton(
                      digit: '5',
                      onPressed: () => _addNumber('5'),
                    ),
                    DialerButton(
                      digit: '6',
                      onPressed: () => _addNumber('6'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DialerButton(
                      digit: '7',
                      onPressed: () => _addNumber('7'),
                    ),
                    DialerButton(
                      digit: '8',
                      onPressed: () => _addNumber('8'),
                    ),
                    DialerButton(
                      digit: '9',
                      onPressed: () => _addNumber('9'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DialerButton(
                      digit: '*',
                      onPressed: () => _addNumber('*'),
                    ),
                    DialerButton(
                      digit: '0',
                      onPressed: () => _addNumber('0'),
                    ),
                    DialerButton(
                      digit: '#',
                      onPressed: () => _addNumber('#'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.backspace),
                      onPressed: _deleteNumber,
                    ),
                    Tooltip(
                      message: 'Click Here to Call',
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 40, 127, 197),
                          ),
                        ),
                        onPressed: _makePhoneCall,
                        child: const Icon(Icons.call),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DialerButton extends StatelessWidget {
  final String digit;
  final VoidCallback onPressed;

  const DialerButton({
    super.key,
    required this.digit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
              (states) => const Color.fromARGB(255, 16, 70, 139)),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.white),
        ),
        onPressed: onPressed,
        child: Text(
          digit,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
