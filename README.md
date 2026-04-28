# Flutter Task Manager App

Welcome to my Final Project for the Flutter Development Internship. This repository contains a complete Task Management application built from the ground up. Serving as the 3rd and final deliverable of the internship track, this project combines all previously learned concepts including UI structuring, navigation, state management, and persistent local storage into a single application.

## 📱 Project Overview
 
This app allows users to efficiently track their day-to-day tasks. It features a custom splash screen, an interface for adding and completing tasks, and a data layer using JSON serialization to ensure tasks are saved locally across app restarts.

### ✨ Features & Highlights

* **Task State Management:** Seamlessly add, delete, and toggle the completion status of tasks using dynamic widget updates.
* **Persistent Storage (SharedPreferences):** Custom Dart models are serialized into JSON strings and stored locally so data is never lost when the app closes.
* **Custom UI & Theming:** Features a custom AppBar, dynamic text styling (such as strikethroughs for completed tasks), and interactive list items utilizing the Flutter `Icons` library.
* **Splash Screen (Bonus Challenge):** A timed, branded introduction screen that routes automatically to the main application hub using secure navigation replacement.

## 📂 Project Structure

The codebase utilizes a clean architecture to separate data models from the user interface:

lib/
│
├── main.dart                      # App entry point and theme configuration
├── models/
│   └── task_model.dart            # Task class with JSON serialization logic
└── screens/
    ├── splash_screen.dart         # Timed introduction screen
    └── task_home_screen.dart      # Core UI, dialog boxes, and state logic