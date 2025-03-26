//
//  ScheduleView.swift
//  FieldMate
//
//  Created by Muhammad Ardiansyah Asrifah on 20/03/25.
//

import SwiftUI

struct ScheduleView: View {
    @State private var selectedDate: Date = Date()
    @State private var showBottomSheet = false
    @State private var tasks: [Task] = [
        Task(time: "08:00", name: "Cek AC", location: "Apple Developer Academy"),
        Task(time: "10:00", name: "Kerusakan Lift", location: "GOP 9"),
        Task(time: "12:00", name: "Water Sprinkler", location: "Purwadika School"),
        Task(time: "14:00", name: "Flush Toilet", location: "GOP 9"),
        Task(time: "16:00", name: "Cek Lampu", location: "GOP 9 Corridor")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Selamat Datang, Engineer! 👷‍♂️👋")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        }
                        Spacer()
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                Text("🛠️ Jadwal Maintenance")
                    .font(.title)
                    .bold()
                    .padding()
                    .foregroundColor(.blue)
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding()
                    .onChange(of: selectedDate) { _ in
                        showBottomSheet = true
                    }
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("🚀 Tugasmu Hari Ini")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                        Text("Total Tugas: \(tasks.count)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack {
                        Text("✅ 0 Selesai")
                            .font(.caption)
                            .foregroundColor(.green)
                        Text("🕒 \(tasks.count / 1) Proses")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 3)
                .padding(.horizontal)
                
                }
            }
            .sheet(isPresented: $showBottomSheet) {
                BottomSheetView(tasks: tasks, selectedDate: selectedDate)
                    .presentationDetents([.medium])
            }
            .background(Color.black.opacity(0.05))
        }
}

#Preview {
    ScheduleView()
}

