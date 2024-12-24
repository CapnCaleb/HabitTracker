//
//  HabitsEditorInteractor.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//

import Foundation
import SwiftData

@MainActor
protocol HabitEditorInteractorProtocol {
    func newHabit(name: String, description: String) throws
    func update(habit: Habit, name: String, description: String) throws
}

@MainActor
class HabitEditorInteractor: HabitEditorInteractorProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func newHabit(name: String, description: String) throws {
        let newHabit = Habit(name: name, habitDescription: description)
        context.insert(newHabit)
        try saveContextIfNeeded()
    }
    
    func update(habit: Habit, name: String, description: String) throws {
        habit.name = name
        habit.habitDescription = description
        try saveContextIfNeeded()
    }
    
    private func saveContextIfNeeded() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
