//
//  ReadingItem.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import Foundation
import Observation

@Observable
class ReadingItem: Identifiable, Hashable, Equatable, Codable {
    
    var title: String
    var url: URL
    let creationDate: Date
    var hasFinishedReading: Bool
    let id: UUID
    
    init(title: String,
         url: URL,
         creationDate: Date = Date(),
         hasFinishedReading: Bool = false,
         id: UUID = UUID()) {
        self.title = title
        self.url = url
        self.creationDate = creationDate
        self.hasFinishedReading = hasFinishedReading
        self.id = id
    }
    
    static func ==(lhs: ReadingItem, rhs: ReadingItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    //MARK: preview helper
    
    static var example: ReadingItem {
        ReadingItem(title: "Apple", url: URL(string: "https://www.apple.com")!)
    }
    
    static var examples: [ReadingItem] {
        [.example,
         ReadingItem(title: "swiftyplace", url: URL(string: "https://www.swiftyplace.com/blog/swiftui-lazyvgrid-and-lazyhgrid")!,
                     hasFinishedReading: true),
         ReadingItem(title: "UIViewRepresentable", url: URL(string: "https://nilcoalescing.com/blog/CustomSizeForUIViewsWrappedInUIViewRepresentable/")!)
        ]
    }
}
