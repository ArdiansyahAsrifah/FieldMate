//
//  BottomSheetView.swift
//  FieldMate
//
//  Created by Muhammad Ardiansyah Asrifah on 20/03/25.
//

import SwiftUI
import ActivityKit

struct BottomSheetView: View {
    let tasks: [Task]
    let selectedDate: Date
    
    @State private var selectedTask: Task? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                List(tasks) { task in
                    Button(action: {
                        selectedTask = task
                        startLiveActivity(for: task)
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.time)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Text(task.name)
                                    .font(.body)
                                Text(task.location)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .sheet(item: $selectedTask) { task in
                TaskDetailView(task: task)
                    .presentationDetents([.large])
            }
        }
    }
    
    func startLiveActivity(for task: Task) {
        let attributes = FieldMateActivityAttributes(taskID: task.id.uuidString)
        let state = FieldMateActivityAttributes.ContentState(
            taskName: task.name,
            taskLocation: task.location,
            progress: 0.0
        )

        do {
            let activity = try Activity<FieldMateActivityAttributes>.request(
                attributes: attributes,
                contentState: state,
                pushType: nil
            )
            print("Live Activity started: \(activity.id)")
        } catch {
            print("Failed to start Live Activity: \(error.localizedDescription)")
        }
    }
}

