//
//  NoteDetailView.swift
//  NoteTakingApp.
//
//  Created by Judah Lomo on 2/12/25.
//

import SwiftUI

struct NoteDetailView: View {
    let note: Note
    @ObservedObject var viewModel: NotesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.title)
                .font(.largeTitle)
                .bold()

            Text(note.content)
                .font(.body)
                .foregroundColor(.secondary)

            Spacer()

            Button(action: {
                viewModel.toggleCompleted(for: note) // Toggle completion status
            }) {
                HStack {
                    Image(systemName: note.isCompleted ? "checkmark.circle.fill" : "circle")
                    Text(note.isCompleted ? "Mark as Incomplete" : "Mark as Completed")
                }
                .foregroundColor(.blue)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Note Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AddEditNoteView(viewModel: viewModel, note: note)) {
                    Text("Edit") // Button to edit the note
                }
            }
        }
    }
}
