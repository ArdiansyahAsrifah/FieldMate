//
//  FieldMateActivityAttributes.swift
//  FieldMate
//
//  Created by Muhammad Ardiansyah Asrifah on 21/03/25.
//

import ActivityKit
import Foundation

struct FieldMateActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var taskName: String
        var taskLocation: String
        var progress: Double
    }

    var taskID: String
}


