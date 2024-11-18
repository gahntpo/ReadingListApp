//
//  PDFViewWrapper.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 17/11/2024.
//

import SwiftUI
import PDFKit

struct PDFViewWrapper: UIViewRepresentable {

    let fileURL: URL
    
    func makeUIView(context: Context) -> PDFView {
        PDFView()
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(url: fileURL)
    }
}
