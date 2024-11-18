//
//  WebNavigationBar.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI

struct WebNavigationBar: View {
    
    @Bindable var webViewState: WebViewState
    @State private var currentWebURL: String = ""
    
    var body: some View {
        HStack {
            ControlGroup{
                Button(action: {
                    webViewState.goBack()
                }) {
                    Image(systemName: "chevron.backward")
                }
                .disabled(!webViewState.canGoBack)
                
                Button(action: {
                    webViewState.goForward()
                }) {
                    Image(systemName: "chevron.forward")
                }
                .disabled(!webViewState.canGoForward)
            }
            .buttonStyle(.bordered)
            .fixedSize()
            
            TextField("current URL", text: $currentWebURL)
                .truncationMode(.middle)
                .textFieldStyle(.roundedBorder)
        }
        .onAppear {
            currentWebURL = webViewState.url?.absoluteString ?? ""
        }
        .onChange(of: webViewState.currentURL) { oldValue, newValue in
            currentWebURL = newValue?.absoluteString ?? ""
        }
    }
}

#Preview {
    WebNavigationBar(webViewState: WebViewState())
}
