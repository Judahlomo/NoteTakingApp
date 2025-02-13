//
//  ContentView.swift
//  NoteTakingApp
//
//  Created by Judah Lomo on 2/12/25.
//  CS4153
//

import SwiftUI

// The main view where all notes are listed
struct ContentView: View {
    // The ViewModel, responsible for handling notes and data persistence
    @StateObject private var viewModel = NotesViewModel()

    var body: some View {
        NavigationStack {
            List {
                // Iterates through all available notes and displays them in the list
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                        HStack {
                            VStack(alignment: .leading) {
                                // Displays the title, applies strikethrough if the note is completed
                                Text(note.title)
                                    .font(.headline)
                                    .strikethrough(note.isCompleted, color: .gray)

                                // Shows a preview of the note’s content, limiting the number of lines displayed
                                Text(note.content)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                            Spacer()
                            // If the note is marked as completed, a green checkmark is displayed
                            if note.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                // Enables swipe-to-delete functionality for notes
                .onDelete(perform: viewModel.deleteNote)
            }
            .navigationTitle("Notes") // Sets the navigation bar title
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showAddNoteView = true // Opens the Add Note view
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                }
            }
            // Presents the Add/Edit Note view as a sheet when `showAddNoteView` is true
            .sheet(isPresented: $viewModel.showAddNoteView) {
                AddEditNoteView(viewModel: viewModel)
            }
        }
    }
}

// Provides a preview of ContentView for SwiftUI previews
#Preview {
    ContentView()
}
