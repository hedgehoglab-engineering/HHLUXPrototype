//
//  Item.swift
//  HHLUXAppClip
//
//  Created by vlad on 16/08/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
