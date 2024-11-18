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
                
                if let url = webViewState.successGeneratedPDFURL {
                    SuccessSavedFileView(url: url)
                        .transition(.move(edge: .bottom))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.bouncy(duration: 2)) {
                                    webViewState.successGeneratedPDFURL = nil
                                }
                            }
                        }
                }
            }
            
            WebNavigationBar(webViewState: webViewState)
                .padding()
                .background(.thinMaterial)
            
        }
        .navigationTitle(webViewState.currentTitle ?? "")
        .onChange(of: reading) { oldValue, newValue in
            webViewState.userRequestedToOpen(newValue.url)
        }
        .onAppear {
            webViewState.userRequestedToOpen(reading.url)
        }
        .toolbar {
            Menu("More", systemImage: "ellipsis.circle") {
                
                if let new = webViewState.currentURL,
                   webViewState.url != new {
                    Button("Create New Reading") {
                        readingViewModel.addNewReadingItem(title: webViewState.currentTitle ?? "title",
                                                           url: new)
                    }
                }
                Button {
                    webViewState.createPDF()
                } label: {
                    Text("Save as PDf")
                }
            }

        }
    }
}

#Preview {
    NavigationStack {
        ReadingDetailView(reading: ReadingItem.example,
                          readingViewModel: ReadingDataViewModel())
    }
}
