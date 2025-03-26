//
//  NextTaskIntent.swift
//  FieldMate
//
//  Created by Muhammad Ardiansyah Asrifah on 22/03/25.
//

import AppIntents
import ActivityKit

struct NextTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "Next Task"

    @MainActor
    func perform() async throws -> some IntentResult {
        guard let activity = Activity<FieldMateActivityAttributes>.activities.first else {
            return .result()
        }

        let nextTasks = [
            FieldMateActivityAttributes.ContentState(taskName: "Check Generator", taskLocation: "Basement 1", progress: 0.0),
            FieldMateActivityAttributes.ContentState(taskName: "Inspect AC", taskLocation: "Server Room", progress: 0.0),
            FieldMateActivityAttributes.ContentState(taskName: "Check Fire Alarm", taskLocation: "Lobby", progress: 0.0)
        ]

        if let currentIndex = nextTasks.firstIndex(where: { $0.taskName == activity.contentState.taskName }),
           currentIndex + 1 < nextTasks.count {
            let nextTask = nextTasks[currentIndex + 1]
            await activity.update(using: nextTask)
            print("🔄 Next Task Updated: \(nextTask.taskName)")
        } else {
            print("❌ No more tasks available.")
        }

        return .result()
    }
}


