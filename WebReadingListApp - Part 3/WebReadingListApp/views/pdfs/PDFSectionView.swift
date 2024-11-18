//
//  PDFSectionView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 17/11/2024.
//

import SwiftUI

struct PDFSectionView: View {
    
    @Bindable var pdfViewModel: PDFViewModel
    @State private var isExpanded: Bool = false
    
    var body: some View {
        Section("Saved PDFs", isExpanded: $isExpanded) {
            ForEach(pdfViewModel.pdfFiles, id: \.self) { file in
                Text(file.lastPathComponent)
                    .lineLimit(1)
                    .tag(ContentView.NavigationSelection.pdf(url: file))
            }
        }
        .onAppear {
            pdfViewModel.loadPdfFiles()
        }
    }
}

#Preview {
    List {
        PDFSectionView(pdfViewModel: PDFViewModel())
    }
}
