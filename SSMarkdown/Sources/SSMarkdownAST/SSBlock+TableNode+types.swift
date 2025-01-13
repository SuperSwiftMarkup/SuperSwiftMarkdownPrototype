//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/12/25.
//

import Foundation

extension SSBlock.TableNode {
    public struct Head {
        public let row: Row
    }
    public struct Body {
        public let rows: [ Row ]
    }
    public struct Row {
        public let cells: [ Cell ]
    }
    public struct Cell {
        public let children: [ SSInline ]
    }
    public enum ColumnAlignment: Equatable {
        case center, left, right
    }
}
