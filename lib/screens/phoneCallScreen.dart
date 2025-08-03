import 'package:flutter/material.dart';
import 'package:vapi/vapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../theme.dart';


class PhoneCallScreen extends StatefulWidget {
  const PhoneCallScreen({super.key});

  @override
  State<PhoneCallScreen> createState() => _PhoneCallScreenState();
}

class _PhoneCallScreenState extends State<PhoneCallScreen> {
  String buttonText = 'Start Call';
  bool isLoading = false;
  bool isCallStarted = false;

  VapiClient? vapiClient;
  VapiCall? currentCall;

  @override
  void initState() {
    super.initState();
  }

  void _handleCallEvents(VapiEvent event) {
    if (event.label == "call-start") {
      setState(() {
          buttonText = 'End Call';
          isLoading = false;
          isCallStarted = true;
        });
      debugPrint('call started');
    }
    if (event.label == "call-end") {
      setState(() {
          buttonText = 'Start Call';
          isLoading = false;
          isCallStarted = false;
          currentCall = null;
        });
      debugPrint('call ended');
    }
    if (event.label == "message") {
      debugPrint('Message: ${event.value}');
    }
  }

  Future<void> _onButtonPressed() async {
    setState(() {
        buttonText = 'Loading...';
        isLoading = true;
      });

    try {
      // Initialize client if not already done
      // The factory automatically selects the appropriate platform implementation
      vapiClient ??= VapiClient("d2a6dd5e-35c7-4607-84c2-50c9c1713cdc");

      if (!isCallStarted) {
        // Start a new call using assistant ID
        final call = await vapiClient!
          .start(assistantId: "336aed3a-fd7d-497a-a2de-a8e7b0c8c48b");

        currentCall = call;
        call.onEvent.listen(_handleCallEvents);
      } else {
        // End the current call
        await currentCall?.stop();
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
          buttonText = 'Start Call';
          isLoading = false;
        });

      // Show error dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to start call: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("AI Phone Call",
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Dignifi',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Connect with support for your reentry journey',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (currentCall != null) RippleAnimation(
                      color: primaryColor,
                      repeat: true,
                      minRadius: 100,
                      maxRadius: 100,
                      ripplesCount: 2,
                      duration: const Duration(milliseconds: 4000),
                      child: Container(),
                    ),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: SvgPicture.asset(width: 30, height: 30, 'assets/images/logo.svg'),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            // Action
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: isLoading ? null : _onButtonPressed,
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (currentCall != null) ...[
                      Text('Call Status: ${currentCall!.status}'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final isMuted = currentCall!.isMuted;
                              currentCall!.setMuted(!isMuted);
                              setState(() {
                                }); // Refresh to update mute status
                            },
                            child: Text(currentCall!.isMuted ? 'Unmute' : 'Mute',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await currentCall!.send({
                                'type': 'add-message',
                                'message': {
                                  'role': 'system',
                                  'content': 'The user pressed a button!'
                                }
                              });
                            },
                            child: const Text('Send Message', style: TextStyle(
                                fontSize: 18,
                              ),),
                          ),
                        ],
                      ),
                    ],
                  ],
                )
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    currentCall?.dispose();
    vapiClient?.dispose();
    super.dispose();
  }
}
