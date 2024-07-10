# Flutter App

## Description
This project is a Flutter application built with the following guidelines:

1. All screens and widgets are stateless.
2. State management is handled using Flutter Riverpod.
3. Widgets are organized into a global `widgets` folder and specific widgets are placed in folders named after their respective screens within the main `widgets` folder.
4. The `provider` folder contains two subfolders:
    - `data`: Contains providers to access data such as APIs and more.
    - `screen`: Contains providers related to the state of screens, for example, search products, booleans, etc.
5. All tasks should be reviewed via pull requests. Do not push code directly into the main branch.

## Project Structure

lib/
├── main.dart
├── widgets/
│ ├── global_widget.dart
│ ├── screen_name/
│ │ ├── specific_widget_1.dart
│ │ ├── specific_widget_2.dart
│ └── ...
├── provider/
│ ├── data/
│ │ ├── api_provider.dart
│ │ └── ...
│ ├── screen/
│ │ ├── search_provider.dart
│ │ └── ...
└── ...


## State Management

This project uses [Riverpod](https://flutter_riverpod.dev/) for state management. Ensure all state-related logic and providers are properly defined and used within the app.

## Contributing

To contribute to this project, please follow these guidelines:

1. **Fork the repository** and create your branch from `main`.
2. **Create a pull request** for each task for reviews. Do not push code directly into the main branch.
3. **Ensure your code follows the project structure and guidelines** mentioned above.
4. **Run tests** to ensure your changes do not break any existing functionality.
5. **Document your code** where necessary to make it easy for others to understand.

## Getting Started

1. **Clone the repository**:
   ```sh
   git clone https://github.com/YounisAzizi/offline-mode.git
   cd offline-mode

2. **Install dependencies**:

   `flutter pub get`

3. **Run the app**:

   `flutter run`


