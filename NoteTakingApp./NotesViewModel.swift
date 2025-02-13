//
//  NotesViewModel.swift
//  NoteTakingApp.
//
//  Created by Judah Lomo on 2/12/25.
//

import SwiftUI

// ViewModel that acts as the data manager for all notes
class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = [] // Holds all notes in the app
    @Published var showAddNoteView: Bool = false // Controls the Add/Edit note screen

    // Function to add a new note to the list
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content, isCompleted: false)
        notes.append(newNote)
        saveNotes() // Ensures persistence
    }

    // Function to toggle a note's completion status
    func toggleCompleted(for note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isCompleted.toggle()
            saveNotes()
        }
    }
    
    func updateNote(_ note: Note, newTitle: String, newContent: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = newTitle
            notes[index].content = newContent
            saveNotes() // Save changes
        }
    }

    // Function to delete notes from the list
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }

    // Saves all notes persistently using JSON
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "SavedNotes")
        }
    }

    // Loads saved notes when the app starts
    private func loadNotes() {
        if let savedData = UserDefaults.standard.data(forKey: "SavedNotes"),
           let decoded = try? JSONDecoder().decode([Note].self, from: savedData) {
            notes = decoded
        }
    }

    // Initializes ViewModel and loads saved notes on startup
    init() {
        loadNotes()
    }
}
