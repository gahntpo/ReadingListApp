//
//  ReadingDetailView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI

struct ReadingDetailView: View {
    
    let reading: ReadingItem
    @Bindable var readingViewModel: ReadingDataViewModel
    
    @State private var webViewState = WebViewState()
    
    var body: some View {
        VStack {
            ZStack {
                WebView(webViewState: webViewState)
                    .edgesIgnoringSafeArea(.bottom)
                if webViewState.isLoading {
                    ProgressView()
                        .controlSize(.large)
                        .tint(Color.accentColor)
                } else if let error = webViewState.error {
                    Text(error.localizedDescription)
                        .foregroundStyle(.pink)
                }
            }
            
            WebNavigationBar(webViewState: webViewState)
                .padding()
                .background(.thinMaterial)
            
        }
        .onChange(of: reading) { oldValue, newValue in
            webViewState.userRequestedToOpen(newValue.url)
        }
        .onAppear {
            webViewState.userRequestedToOpen(reading.url)
        }
        .toolbar {
            if let new = webViewState.currentURL,
               webViewState.url != new {
                Button("Create New Reading") {
                    readingViewModel.addNewReadingItem(title: webViewState.currentTitle ?? "title",
                                                       url: new)
                }
            }
        }
    }
}

#Preview {
    ReadingDetailView(reading: ReadingItem.example,
                      readingViewModel: ReadingDataViewModel())
}
