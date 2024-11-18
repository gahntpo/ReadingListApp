//
//  ReadingListView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI

struct ReadingSectionView: View {
    
    @Bindable var readingViewModel: ReadingDataViewModel

    
    var body: some View {
        Section("Reading List") {
            ForEach($readingViewModel.readingList,
                    editActions: [.move, .delete]) { $item in
                
                ReadingItemRow(readingItem: item)
                    .tag(ContentView.NavigationSelection.readingItem(item: item))
                    .swipeActions(edge: .leading) {
                        Button(item.hasFinishedReading ? "Mark as Unfinished" :"Mark as Finished") {
                            $item.wrappedValue.hasFinishedReading.toggle()
                        }
                        .tint(item.hasFinishedReading ? .gray : .green)
                    }
            }
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
        List{
            ReadingSectionView(readingViewModel: ReadingDataViewModel())
        }
    }
}
