import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgentDetailPage extends StatelessWidget {
  final Map<String, dynamic> agent;

  const AgentDetailPage({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(agent["name"] ?? "Agent Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Agent Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                agent["photoUrl"] ?? "",
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 250),
              ),
            ),
            const SizedBox(height: 20),

            // Agent Name
            Text(
              agent["name"] ?? "No Name",
              style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Agent Bio
            Text(
              agent["bio"] ?? "On Your Service.",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Fetch and Display Agent's Packages
            const Text(
              "Packages:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(agent["id"]) // Use agent id to access subcollection
                  .collection("packages")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text("No packages available.");
                }

                var packages = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    final package =
                    packages[index].data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: ListTile(
                        leading: Image.network(
                          package["image"] ?? "",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                        ),
                        title: Text(
                          package["text"] ?? "No Title",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          package["description"] ?? "No Description",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          "\$${package["price"] ?? "N/A"}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {

                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
