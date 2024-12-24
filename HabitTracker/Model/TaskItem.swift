//
//  TaskItem.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//


import Foundation
import SwiftData

@Model
class TaskItem: Identifiable, Equatable {
    private(set) var id: UUID
    var name: String
    var note: String
    private(set) var created: Date
    private(set) var completed: Date?
    
    var isComplete: Bool {
        completed != nil
    }
    
    init(name: String) {
        self.id = UUID()
        self.name = name
        self.note = ""
        self.created = Calendar.current.startOfDay(for: .now)
        self.completed = nil
    }
    
    func markComplete() {
        self.completed = .now
    }
}
