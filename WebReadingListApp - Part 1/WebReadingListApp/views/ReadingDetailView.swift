//
//  ReadingDetailView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI

struct ReadingDetailView: View {
    
    let reading: ReadingItem
    
    var body: some View {
        //TODO: add webview
        Text(reading.url.absoluteString)
    }
}

#Preview {
    ReadingDetailView(reading: ReadingItem.example)
}
