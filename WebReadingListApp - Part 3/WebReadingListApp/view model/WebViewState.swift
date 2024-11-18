//
//  WebViewState.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI
import Observation
import WebKit

@Observable
class WebViewState {
    
    var url: URL? = nil
    var isLoading = false
    var error: Error?
    
   var currentURL: URL? = nil
    var currentTitle: String? = nil
    
    var successGeneratedPDFURL: URL? = nil
    
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
    
    
    func createPDF() {
        
        guard let webView else { return }
        
        webView.createPDF { result in
            
            switch result {
                case .success(let data):
                    self.savePDFToDisk(data)
                case .failure(let failure):
                    print("error creating pdf: \(failure)")
                    //TODO: show error feedback to user
            }
            
        }
        
    }
    
    func savePDFToDisk(_ data: Data) {
        let documentsURL = URL.documentsDirectory
        
        let title = webView?.title ?? "untitled"
        let fileURL = documentsURL.appendingPathComponent("\(title).pdf")
        
        do {
            try data.write(to: fileURL)
            withAnimation(.bouncy(duration: 2)) {
                self.successGeneratedPDFURL = fileURL
            }
            print("success \(fileURL.absoluteString)")
        } catch {
            print("error saving pdf: \(error)")
            //TODO: show error feedback to user
        }
    }
}
