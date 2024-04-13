# WhatsApp for iPad using WhatsApp Web

This project aims to provide a WhatsApp experience for iPad users by utilizing WhatsApp Web. It allows users to access WhatsApp messaging and features directly from their iPad devices.

## Overview

The project comprises the following components:

1. **ContentView**: This SwiftUI view initializes a `Webview` and displays it, loading WhatsApp Web. 

2. **Webview**: This is a `UIViewRepresentable` struct that wraps a `WKWebView`. It loads WhatsApp Web and provides navigation functionality.

3. **WebViewHelper**: This class acts as a delegate for `WKWebView` navigation events. It handles the interactions between the web view and the iPad app.

## How to Use

To use this project:

1. Clone the repository to your local machine.

   ```bash
   git clone https://github.com/your_username/whatsapp-for-ipad.git
   ```

2. Open the project in Xcode.

3. Build and run the project on your iPad simulator or a physical iPad device.

4. Sign in to WhatsApp Web by scanning the QR code using your WhatsApp account on your iPhone.

5. Start using WhatsApp on your iPad!

## Features

- Access all WhatsApp messaging features on your iPad.
- Receive notifications for new messages through browser notifications.

## Compatibility

- Compatible with iPad devices running iOS 14 and above.

## Known Issues

- Due to limitations of WhatsApp Web, certain features may not be fully functional or available.

## Author

[Akshay Kadam](https://github.com/Akshayykadam)

## Acknowledgments

Special thanks to the SwiftUI and iOS development community for their valuable resources and support.

Enjoy using WhatsApp on your iPad!
