//
//  SuccessSavedFileView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 17/11/2024.
//

import SwiftUI

struct SuccessSavedFileView: View {
    
    let url: URL
    
    var body: some View {
        Label("Saved PDF to: \(url.lastPathComponent)", systemImage: "checkmark.circle.fill")
            .padding()
            .background(Color.green)
            .cornerRadius(5)
            .shadow(radius: 5)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(50)
            .padding(.bottom, 0)
    }
}

#Preview {
    SuccessSavedFileView(url: URL(string: "//Users/karinprater/Library/Developer/CoreSimulator/Devices/880EFCD5-0829-47B3-BC5C-F01FD7CC6CC2/data/Containers/Data/Application/82F27C43-1362-4C17-927A-60B13AC26C8A/Documents/title.pdf")!)
}
