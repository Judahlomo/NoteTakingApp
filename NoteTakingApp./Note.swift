//
//  Note.swift
//  NoteTakingApp.
//
//  Created by Judah Lomo on 2/12/25.
//

import Foundation

// Represents a single note within the app
struct Note: Identifiable, Codable {
    let id: UUID  // Every note gets a unique identifier
    var title: String      // Stores the note's title
    var content: String    // Holds the actual content of the note
    var isCompleted: Bool  // Tracks whether the note is marked as finished

    // Custom initializer allowing default values
    init(id: UUID = UUID(), title: String, content: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.content = content
        self.isCompleted = isCompleted
    }
}
