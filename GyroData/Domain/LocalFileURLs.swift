//
//  FileManagerURLs.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/15.
//

import Foundation

enum LocalFileURLs {
    private static let fileManager = FileManager.default
    
    static var fileURL: URL? {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    static func receiveURL(by title: String) -> URL? {
        guard let baseURL = fileURL else { return nil }
        
        let url = baseURL.appendingPathComponent(title)
        
        return url
    }
    
    @discardableResult
    static func remove(by url: URL) -> Bool {
        do {
            try fileManager.removeItem(at: url)
            return true
        } catch {
            return false
        }
    }
}
