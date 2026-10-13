Sadaka QR Scanner

A Flutter app used by the admin side of the Sadaka donation app. It scans a donor's QR code and exchanges the user's reward coins through the backend API.

<!-- ## Screenshots <p float="left"> <img src="screenshots/login.png" width="200" /> <img src="screenshots/scan.png" width="200" /> </p> -->
Features
Admin login
QR code scanning with the device camera
Exchange and update the user's reward coins through the API
Light/dark theme controller
Tech Stack
Flutter / Dart
State management: Bloc / Cubit
Networking: Dio (REST APIs)
Scanning: flutter_barcode_scanner
Local storage: shared_preferences
Run the project
bash
git clone https://github.com/basmaabdou/qrcode.git
cd qrcode
flutter pub get
flutter run
