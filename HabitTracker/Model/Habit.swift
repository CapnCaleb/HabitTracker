//
//  Habit.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//


import Foundation
import SwiftData

@Model
class Habit: Identifiable, Equatable {
    private(set) var id: UUID
    var name: String
    var habitDescription: String
    private(set) var created: Date
    var updated: Date
    var endDate: Date?
    
    var isArchived: Bool { endDate != nil }
    
    static func == (rhs: Habit, lhs: Habit) -> Bool {
        rhs.id == lhs.id
    }
    
    init(name: String, habitDescription: String) {
        let workingDate = Calendar.current.startOfDay(for: Date.now)
        self.id = UUID()
        self.name = name
        self.habitDescription = habitDescription
        self.created = workingDate
        self.updated = workingDate
        self.endDate = nil
    }
}
