//
//  AddEditNoteView.swift
//  NoteTakingApp.
//
//  Created by Judah Lomo on 2/12/25.
//

import SwiftUI

struct AddEditNoteView: View {
    @ObservedObject var viewModel: NotesViewModel

    // The note being edited (if any)
    var note: Note? = nil

    // Stores title and content for editing or adding
    @State private var title: String = ""
    @State private var content: String = ""

    // Dismiss the view after saving
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: NotesViewModel, note: Note? = nil) {
        self.viewModel = viewModel
        self.note = note
        _title = State(initialValue: note?.title ?? "")  // Pre-fill title if editing
        _content = State(initialValue: note?.content ?? "") // Pre-fill content if editing
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter note title", text: $title)
                }

                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationTitle(note == nil ? "New Note" : "Edit Note") // Change title based on mode
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let existingNote = note {
                            viewModel.updateNote(existingNote, newTitle: title, newContent: content) // Edit mode
                        } else {
                            viewModel.addNote(title: title, content: content) // Add mode
                        }
                        presentationMode.wrappedValue.dismiss() // Close the screen
                    }
                }
            }
        }
    }
}
