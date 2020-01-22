//
//  PersistenceHelper.swift
//  PersistencePixabayLab
//
//  Created by Kelby Mittan on 1/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error {
    case savingError(Error) // associated value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    
    private static var pixImages = [PixImage]()
    
    private static let filename = "favImages.plist"
    
    static func createImage(image: PixImage) throws {
        
        pixImages.append(image)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    static func save() throws {
        
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        do {
            let data = try PropertyListEncoder().encode(pixImages)
            
            try data.write(to: url, options: .atomic)
            
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    static func loadImages() throws -> [PixImage] {

        let url = FileManager.pathToDocumentsDirectory(with: filename)

        if FileManager.default.fileExists(atPath: url.path) {

            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    pixImages = try PropertyListDecoder().decode([PixImage].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        } else {
           throw DataPersistenceError.fileDoesNotExist(filename)
        }

        return pixImages
    }
}

