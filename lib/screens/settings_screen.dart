import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Appearance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

            child: ListTile(
              title: const Text("App Theme"),
              trailing: DropdownButton<AppThemeMode>(
                value: themeProvider.appThemeMode,
                underline: const SizedBox(),

                items: const [

                  DropdownMenuItem(
                    value: AppThemeMode.system,
                    child: Text("Use System Theme"),
                  ),

                  DropdownMenuItem(
                    value: AppThemeMode.light,
                    child: Text("Light"),
                  ),

                  DropdownMenuItem(
                    value: AppThemeMode.dark,
                    child: Text("Dark"),
                  ),

                ],
                onChanged: (mode) {
                  if (mode != null) {
                    themeProvider.setTheme(mode);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
