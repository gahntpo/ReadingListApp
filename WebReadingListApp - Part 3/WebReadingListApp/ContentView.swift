//
//  ContentView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    enum NavigationSelection: Identifiable, Hashable {
        case pdf(url: URL)
        case readingItem(item: ReadingItem)
        var id: String {
            switch self {
                case .pdf(let url):
                    return url.absoluteString
                case .readingItem(let item):
                    return item.id.uuidString
            }
        }
    }
    
    @State private var pdfViewModel = PDFViewModel()
    @State private var readingViewModel = ReadingDataViewModel()
    
    @State private var selection: NavigationSelection? = nil
    @State private var newReadingEditorIsShown: Bool = false
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                PDFSectionView(pdfViewModel: pdfViewModel)
                ReadingSectionView(readingViewModel: readingViewModel)
            }
            .navigationTitle("Your Reading List")
            .toolbar {
                Button {
                    newReadingEditorIsShown.toggle()
                } label: {
                    Label("Add New Reading Item", systemImage: "plus")
                }

                EditButton()
            }
            .sheet(isPresented: $newReadingEditorIsShown) {
                ReadingDataEditorView(readingViewModel: readingViewModel)
            }
           
        } detail: {
            if let selection {
                
                switch selection {
                    case .pdf(let url):
                        PDFDetailView(fileURL: url,
                                      pdfViewModel: pdfViewModel)
                    case .readingItem(let item):
                        ReadingDetailView(reading: item,
                                          readingViewModel: readingViewModel)
                }
                
                
            } else {
                ContentUnavailableView("Select a Reading Item", systemImage: "book")
            }
        }
        .onChange(of: scenePhase) { _, phase in
            switch phase {
                case .active:
                    readingViewModel.load()
                case .background, .inactive:  readingViewModel.save()
                @unknown default:
                    break
            }
        }
    }
}

#Preview {
    ContentView()
}
