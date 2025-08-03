import 'package:flutter/material.dart';
import 'package:vapi/vapi.dart';


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
    return Scaffold(
      appBar: AppBar(
        title: const SelectableText('Vapi Test App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SelectableText(
              'Vapi Flutter SDK Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: isLoading ? null : _onButtonPressed,
              child: Text(buttonText),
            ),
            const SizedBox(height: 16),
            if (currentCall != null) ...[
              Text('Call Status: ${currentCall!.status}'),
              const SizedBox(height: 8),
              Text('Call ID: ${currentCall!.id}'),
              const SizedBox(height: 8),
              Text('Assistant ID: ${currentCall!.assistantId}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final isMuted = currentCall!.isMuted;
                      currentCall!.setMuted(!isMuted);
                      setState(() {}); // Refresh to update mute status
                    },
                    child: Text(currentCall!.isMuted ? 'Unmute' : 'Mute'),
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
                    child: const Text('Send Message'),
                  ),
                ],
              ),
            ],
          ],
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