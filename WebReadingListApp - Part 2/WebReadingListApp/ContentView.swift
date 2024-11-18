//
//  ContentView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var readingViewModel = ReadingDataViewModel()
    @State private var selection: ReadingItem? = nil
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationSplitView {
            ReadingListView(readingViewModel: readingViewModel,
                            selection: $selection)
        } detail: {
            if let selection {
                ReadingDetailView(reading: selection,
                                  readingViewModel: readingViewModel)
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
