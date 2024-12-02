import 'package:flutter/material.dart';

class KeySkillsScreen extends StatefulWidget {
  const KeySkillsScreen({super.key});

  @override
  State<KeySkillsScreen> createState() => _KeySkillsScreenState();
}

class _KeySkillsScreenState extends State<KeySkillsScreen> {
  final List<String> selectedSkills = [];
  final List<String> allSkills = [
    "UX Research",
    "Prototype",
    "UX Design",
    "Vision",
    "Usability",
    "User Flow",
    "UX Writing Skills",
    "Empathy",
    "Sketch",
  ];

  List<String> filteredSkills = [];
  final TextEditingController _skillController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    filteredSkills = allSkills;
  }

  void addSkill(String skill) {
    if (skill.isNotEmpty && !selectedSkills.contains(skill)) {
      setState(() {
        selectedSkills.add(skill);
      });
    }
  }

  void removeSkill(String skill) {
    setState(() {
      selectedSkills.remove(skill);
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      filteredSkills = allSkills
          .where((skill) => skill.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Key Skills"),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add skills that best define your expertise, e.g., Direct Marketing, Oracle, Java, etc. (Minimum 1)",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            // Selected Skills Chips
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedSkills.map((skill) {
                return InputChip(
                  label: Text(skill),
                  onDeleted: () => removeSkill(skill),
                  backgroundColor: Colors.blue[100],
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            // Search or Add Skill Field
            TextField(
              controller: _skillController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                labelText: "Add Skills",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    addSkill(_skillController.text);
                    _skillController.clear();
                    onSearchChanged('');
                  },
                ),
              ),
            ),
            if (isSearching && filteredSkills.isNotEmpty) ...[
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSkills.length,
                  itemBuilder: (context, index) {
                    final skill = filteredSkills[index];
                    return ListTile(
                      title: Text(skill),
                      onTap: () {
                        addSkill(skill);
                        _skillController.clear();
                        onSearchChanged('');
                      },
                    );
                  },
                ),
              ),
            ] else if (isSearching && filteredSkills.isEmpty) ...[
              SizedBox(height: 8),
              Text("No skills found", style: TextStyle(color: Colors.grey)),
            ],
            if (!isSearching) ...[
              SizedBox(height: 16),
              Text(
                "Or you can select from the suggested set of skills",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              // Suggested Skills Chips
              Wrap(
                spacing: 8,
                children: allSkills.map((skill) {
                  return GestureDetector(
                    onTap: () {
                      addSkill(skill);
                    },
                    child: Chip(
                      label: Text(skill),
                      backgroundColor: selectedSkills.contains(skill)
                          ? Colors.blue[100]
                          : Colors.grey[200],
                    ),
                  );
                }).toList(),
              ),
            ],
            Spacer(),
            // Save and Cancel Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Save
                      print("Selected Skills: $selectedSkills");
                    },
                    child: Text("Save"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle Cancel
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
