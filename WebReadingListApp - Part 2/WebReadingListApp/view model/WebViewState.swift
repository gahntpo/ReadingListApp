//
//  WebViewState.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import Foundation
import Observation
import WebKit

@Observable
class WebViewState {
    
    var url: URL? = nil
    var isLoading = false
    var error: Error?
    
   var currentURL: URL? = nil
    var currentTitle: String? = nil
    
    var canGoBack = false
    var canGoForward = false
    
    weak var webView: WKWebView?
    
    init(url: URL? = nil) {
        self.url = url
    }
    
    
    func userRequestedToOpen(_ url: URL) {
        self.url = url
        self.error = nil
        self.currentURL = nil
    }
    
    func update(isLoading: Bool, error: Error? = nil) {
        self.isLoading = isLoading
        self.error = error
    }
    
    func update(currentURL: URL?, currentTitle: String?) {
        self.currentURL = currentURL
        self.currentTitle = currentTitle
        updateNavigationState()
    }
    
    func updateNavigationState() {
        self.canGoBack = webView?.canGoBack ?? false
        self.canGoForward = webView?.canGoForward ?? false
    }
    
    func goBack() {
        webView?.goBack()
    }

    func goForward() {
        webView?.goForward()
    }

    func reload() {
        webView?.reload()
    }
}
