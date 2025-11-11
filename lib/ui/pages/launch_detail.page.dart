import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/launch.model.dart';

class LaunchDetailsPage extends StatelessWidget {
  final Launch launch;

  const LaunchDetailsPage({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(launch.date);

    return Scaffold(
      appBar: AppBar(
        title: Text(launch.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  launch.patchUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  launch.failure == null
                      ? Icons.check_circle
                      : Icons.cancel,
                  color: launch.failure == null ? Colors.green : Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Mission details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              launch.details.isNotEmpty
                  ? launch.details
                  : "No details available.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Rocket information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow("Name", launch.rocket.name),
                    _infoRow("Height", "${launch.rocket.height} m"),
                    _infoRow("Diameter", "${launch.rocket.diameter} m"),
                    _infoRow("Mass", "${launch.rocket.mass} kg"),
                    _infoRow("Engine type", launch.rocket.engineType),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (launch.failure != null) ...[
              const Text(
                "Failure details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.red[50],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow("Time (s)", "${launch.failure!.time}"),
                      if (launch.failure!.altitude != null)
                        _infoRow("Altitude (m)", "${launch.failure!.altitude}"),
                      _infoRow("Reason", launch.failure!.reason),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            if (launch.articleUrl.isNotEmpty)
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    launchUrl(Uri.parse(launch.articleUrl));
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text("Read article"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}