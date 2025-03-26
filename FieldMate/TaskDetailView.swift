//  TaskDetailView.swift
//  FieldMate
//
//  Created by Muhammad Ardiansyah Asrifah on 20/03/25.
//

import SwiftUI
import ActivityKit

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    let task: Task
    @State private var isReschedulePresented = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var taskTime: Date
    @State private var activity: Activity<FieldMateActivityAttributes>? = nil
    
    init(task: Task) {
        self.task = task
        self._taskTime = State(initialValue: Date())
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                        Text("Back")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    .padding(.top)
                    Spacer()
                }
                
                Text(task.name)
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading, spacing: 8) {
                    Button(action: { isReschedulePresented = true }) {
                        Label("Jam: \(formattedTime(taskTime))", systemImage: "clock")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    
                    Label("Lokasi: \(task.location)", systemImage: "mappin.and.ellipse")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
                
                // Deskripsi
                VStack(alignment: .leading, spacing: 5) {
                    Text("Deskripsi")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("Teknisi lapangan bertugas untuk melakukan pengecekan dan pemeliharaan peralatan atau sistem yang ada di lokasi. Tugas ini meliputi inspeksi kondisi perangkat, pengecekan kelistrikan, perbaikan jika diperlukan, serta memastikan semua perangkat berfungsi dengan baik sesuai dengan standar operasional.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                Divider()
                
                VStack(spacing: 15) {
                    Button(action: startLiveActivity) {
                        Label("Mulai Tugas", systemImage: "play.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: openWhatsApp) {
                        Label("Komunikasi Dengan Tenant", systemImage: "message.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                
            }
            .padding()
        }
        .sheet(isPresented: $isReschedulePresented) {
            RescheduleView(selectedDate: $selectedDate, selectedTime: $selectedTime, taskTime: $taskTime, isPresented: $isReschedulePresented)
        }
    }
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func startLiveActivity() {
        let attributes = FieldMateActivityAttributes(taskID: task.id.uuidString)
        let state = FieldMateActivityAttributes.ContentState(
            taskName: task.name,
            taskLocation: task.location,
            progress: 0.0
        )
        
        do {
            let newActivity = try Activity<FieldMateActivityAttributes>.request(
                attributes: attributes,
                contentState: state,
                pushType: nil
            )
            activity = newActivity
            print("✅ Live Activity Started!")
        } catch {
            print("❌ Failed to start Live Activity: \(error.localizedDescription)")
        }
    }
    
    func openWhatsApp() {
        let phoneNumber = "628123456789"
        let urlString = "https://wa.me/\(phoneNumber)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("❌ WhatsApp not installed or invalid URL")
        }
    }
    
    struct RescheduleView: View {
        @Binding var selectedDate: Date
        @Binding var selectedTime: Date
        @Binding var taskTime: Date
        @Binding var isPresented: Bool
        
        var body: some View {
            VStack {
                DatePicker("Pilih Tanggal", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                
                DatePicker("Select Jam", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .padding()
                
                Button("Reschedule") {
                    let newDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: selectedTime),
                                                        minute: Calendar.current.component(.minute, from: selectedTime),
                                                        second: 0,
                                                        of: selectedDate) ?? Date()
                    taskTime = newDate
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

