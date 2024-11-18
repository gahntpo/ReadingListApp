//
//  ReadingListView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI

struct ReadingListView: View {
    
    @Bindable var readingViewModel: ReadingDataViewModel
    @State private var newReadingEditorIsShown: Bool = false
    @Binding var selection: ReadingItem?
    
    var body: some View {
        List($readingViewModel.readingList,
             editActions: [.move, .delete],
             selection: $selection) { $item in
            
            ReadingItemRow(readingItem: item)
                .tag(item)
                .swipeActions(edge: .leading) {
                    Button("Toggle isFinished") {
                        item.hasFinishedReading.toggle()
                    }
                }
        }
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
    }
}

fileprivate struct ReadingItemRow: View {
    
    let readingItem: ReadingItem
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            
            Image(systemName: readingItem.hasFinishedReading ? "book.fill" : "book")
                .foregroundStyle(.green)
            
            VStack(alignment: .leading) {
                Text(readingItem.title)
                Text(readingItem.creationDate.formatted(.dateTime))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }

    }
}

#Preview {
    
    @State @Previewable var selection: ReadingItem?
    
    NavigationStack {
        ReadingListView(readingViewModel: ReadingDataViewModel(),
                        selection: $selection)
    }
}
