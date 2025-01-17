//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/15/25.
//

import Foundation

public struct SSDocument {
    public let nodes: [ SSBlock ]
}

extension SSDocument {
    public static func read(from url: URL) throws -> SSDocument {
        let data = try String.init(contentsOf: url)
        return SSDocument.parseFrom(source: data)
    }
}
