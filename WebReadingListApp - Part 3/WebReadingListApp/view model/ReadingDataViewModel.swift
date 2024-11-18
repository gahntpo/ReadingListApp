//
//  ReadingDataViewModel.swift
//  WebReadingListApp
//
//  Created by Karin Prater on 16/11/2024.
//

import Foundation
import Observation

@Observable
class ReadingDataViewModel {
    
    var readingList: [ReadingItem] = []
    
    init () {
   
    }
    
    func addNewReadingItem(title: String, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        //TODO: show error to user if string is not valid url
        addNewReadingItem(title: title, url: url)
    }
    
    func addNewReadingItem(title: String, url: URL) {
        let new = ReadingItem(title: title, url: url)
        readingList.append(new)
        
        save()
    }
    
    func supportDirectory() -> URL? {
        do {
            return try FileManager.default.url(for: .applicationSupportDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: true)
        } catch {
            print("error creating support directory: \(error)")
            return nil
        }
    }
    
    func fileURL() -> URL {
        let directory = supportDirectory() ?? URL.documentsDirectory
        return directory.appendingPathComponent("readingList.json")
    }
    
    func save() {
        // take swift types and convert to Data -> Codable
        do {
            let data = try JSONEncoder().encode(readingList)
            let url = fileURL()
            try data.write(to: url)
            print("file location \(url.absoluteString)")
        } catch {
            print("error \(error)")
        }
        // create url for file
        // write data to file
    }

    func load() {
        let url = fileURL()
        do {
            let data = try Data(contentsOf: url)
            self.readingList = try JSONDecoder().decode([ReadingItem].self, from: data)
        } catch {
            print("error loading data: \(error)")
            useSampleData()
        }
    }
    
    func useSampleData() {
        self.readingList = ReadingItem.examples
    }
    
}

