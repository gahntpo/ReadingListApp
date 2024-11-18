//
//  WebView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    @Bindable var webViewState: WebViewState
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        print("makeUIView")
         let view = WKWebView()
        load(view)
        view.navigationDelegate = context.coordinator
        webViewState.webView = view
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("updateUIView")
        guard let url = webViewState.url else { return }
        
        if uiView.url == nil {
            load(uiView)
        } else if uiView.url != url {
            load(uiView)
        }
    }
    
    func load(_ uiView: WKWebView) {
        guard let url = webViewState.url else { return }
        
        uiView.load(URLRequest(url: url))
        webViewState.update(isLoading: true)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView,
                     didStartProvisionalNavigation navigation: WKNavigation!) {
            print("webView - didStartProvisionalNavigation")
            parent.webViewState.update(isLoading: true)
        }
        
        func webView(_ webView: WKWebView,
                     didCommit navigation: WKNavigation!) {
            print("webView - didCommit")
        }
        
        func webView(_ webView: WKWebView,
                     didFinish navigation: WKNavigation!) {
            print("webView - didFinish")
            parent.webViewState.update(isLoading: false)
            parent.webViewState.update(currentURL: webView.url,
                                       currentTitle: webView.title)
            
        }
        
        func webView(_ webView: WKWebView,
                     didFail navigation: WKNavigation!,
                     withError error: any Error) {
            print("webView - didFail")
            parent.webViewState.update(isLoading: false,
                                       error: error)
        }
    }
}

#Preview {
    WebView(webViewState: WebViewState(url: URL(string: "www.apple.com")))
}
