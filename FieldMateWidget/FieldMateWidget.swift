//
//  FieldMateLiveActivity.swift
//  FieldMateWidget
//
//  Created by Muhammad Ardiansyah Asrifah on 21/03/25.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct FieldMateLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FieldMateActivityAttributes.self) { context in
            VStack {
                Text("🛠️ \(context.state.taskName)")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.top, 30)
                Text(context.state.taskLocation)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
//                let remainingTime = Int((1 - context.state.progress) * 120)
//                Text("⏳ Tugas Berikutnya Pada Jam: \(remainingTime) Menit")
                Text("⏳ Tugas Berikutnya Pada Jam: 09.00 WIB")
                    .font(.footnote)
                    .foregroundColor(.orange)
                
                ProgressView(value: context.state.progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding(.horizontal)
                    .tint(context.state.progress < 1.0 ? .yellow : .green)
                
                if context.state.progress >= 1.0 {
                    Text("✅ Tugas Selesai!")
                        .font(.footnote)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .activityBackgroundTint(Color.black.opacity(0.8))
            .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                
                DynamicIslandExpandedRegion(.leading) {
                    Text("🛠️")
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text(context.state.taskName)
//                        Text("⏳ \(Int((1 - context.state.progress) * 120)) Menit Lagi")
                        Text("Apple Developer Academy")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
//                    Text("\(Int(context.state.progress * 100))%")
                    Text("")
                        .bold()
                        .foregroundColor(context.state.progress < 1.0 ? .yellow : .green)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        Text("Tugas Berikutnya : Mengecek Lift🚡")
                            .font(.caption)
                            .foregroundColor(.white)
                        }
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text("08:00")
                        .font(.subheadline)
                }
                
            } compactLeading: {
                Text("🛠️")
            } compactTrailing: {
//                Text("\(Int(context.state.progress * 100))%")
                Text("\(context.state.taskName)")
                    .bold()
            } minimal: {
                Text(context.state.progress >= 1.0 ? "✅" : "🔧")
            }
        }
    }
}

@main
struct FieldMateWidgetBundle: WidgetBundle {
    var body: some Widget {
        FieldMateLiveActivity()
    }
}

