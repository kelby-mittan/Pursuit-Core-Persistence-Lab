//
//  FileManager.swift
//  PersistencePixabayLab
//
//  Created by Kelby Mittan on 1/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation

extension FileManager {
    
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func pathToDocumentsDirectory(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
    
}
