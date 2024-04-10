//
//  ContentView.swift
//  WhatsappWeb
//
//  Created by Akshay Kadam on 10/04/24.
//

import SwiftUI
import WebKit
import UserNotifications

struct ContentView: View {
    var body: some View {
        Webview(url: URL(string: "https://web.whatsapp.com/")!)
        
    }
}

// Webview struct representing the WebView using UIViewRepresentable
struct Webview: UIViewRepresentable {
    
    let url: URL
    let navigationHelper = WebViewHelper()
    
    // Create and configure the WKWebView
    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        // Perform notification setup
        GetNotification()
        
        let webview = WKWebView()
        webview.navigationDelegate = navigationHelper
        
        // Load the provided URL
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
        
        // Setting custom user agent
        let userAgent = "Mozilla/5.0 (X11; Linux i586; rv:31.0) Gecko/20100101 Firefox/71.0"
        webview.customUserAgent = userAgent
        
        return webview
    }

    // Update the WebView with a new URL
    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}

// WebViewHelper class acting as delegate for WKWebView navigation events
class WebViewHelper: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
    
    // Handle completion of web page navigation
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webview didFinishNavigation")
        // Register for push notifications upon page load completion
        registerForPushNotifications(webView)
    }
    
    // Handle start of provisional navigation
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    // Handle commit of navigation
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webviewDidCommit")
    }
    
    // Handle authentication challenge
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("didReceiveAuthenticationChallenge")
        completionHandler(.performDefaultHandling, nil)
    }
    
    // Register for push notifications using JavaScript injection
    func registerForPushNotifications(_ webView: WKWebView) {
        let script = """
        // Request permission for push notifications
        function requestNotificationPermission() {
            Notification.requestPermission().then(function(permission) {
                console.log('Permission:', permission);
                if (permission === 'granted') {
                    console.log('Push notifications are allowed');
                    // If permission is granted, register for push notifications here
                }
            }).catch(function(error) {
                console.error('Permission:', error);
            });
        }

        requestNotificationPermission();
        """
        
        let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        webView.configuration.userContentController.addUserScript(userScript)
    }

    // Handle reception of messages from JavaScript
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Received message:", message)
    }
}


func GetNotification(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("Access granted!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
}

#Preview {
    ContentView()
}
