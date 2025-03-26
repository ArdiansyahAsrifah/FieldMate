//
//  Task.swift
//  FieldMate
//
//  Created by Muhammad Ardiansyah Asrifah on 22/03/25.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    let time: String
    let name: String
    let location: String


    init(time: String, name: String, location: String) {
        self.time = time
        self.name = name
        self.location = location
    }
}
