//
//  ReadingDataEditorView.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import SwiftUI

struct ReadingDataEditorView: View {
    
    enum FocusedField {
        case title, url
    }
    
    @Bindable var readingViewModel: ReadingDataViewModel
    @State var newURLString = ""
    @State var title = ""
    
    @FocusState private var focusedField: FocusedField?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Create New Reading Item")
                .font(.title)
            TextField("Title", text: $title)
                .focused($focusedField, equals: .title)
            
            TextField("URL", text: $newURLString)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .url)
            
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                
                Button("Save") {
                    finish()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        .onSubmit {
            if focusedField == .title {
                focusedField = .url
            } else {
                finish()
            }
        }
        .onAppear {
            focusedField = .title
        }
    }
    
    func finish() {
        if let url = URL(string: newURLString) {
            readingViewModel.addNewReadingItem(title: title, urlString: newURLString)
            dismiss()
        }
    }
}

#Preview {
    ReadingDataEditorView(readingViewModel: ReadingDataViewModel())
}
