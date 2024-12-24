//
//  HabitEditorInteractorTests.swift
//  HabitTracker
//
//  Created by Caleb on 12/22/24.
//

import Foundation
import SwiftData
import Testing

@testable import HabitTracker

@MainActor
struct HabitEditorInteractorTests {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let fetchDescriptor = FetchDescriptor<Habit>()
    let name = "Test"
    let description = "Test description"
    
    @Test func saveNewHabitFromEditor() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let interactor = HabitEditorInteractor(context: container.mainContext)
        
        try interactor.newHabit(name: name, description: description)
        
        let fetchDescriptor = FetchDescriptor<Habit>()
        let habits = try container.mainContext.fetch(fetchDescriptor)
        let newHabit = try #require(habits.first)
        
        #expect(habits.count == 1)
        #expect(newHabit.name == name)
        #expect(newHabit.habitDescription == description)
    }
    
    @Test func updateHabitFromEditor() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let interactor = HabitEditorInteractor(context: container.mainContext)
        
        try interactor.newHabit(name: name, description: description)
        
        //fetch, update habit, save
        let habits = try container.mainContext.fetch(fetchDescriptor)
        let savedHabit = try #require(habits.first)
        let updatedName = "Updated name"
        let updatedDescription = "Updated description"
        try interactor.update(habit: savedHabit, name: updatedName, description: updatedDescription)
        
        //fetch latest change from context
        let updatedHabits = try container.mainContext.fetch(fetchDescriptor)
        let updatedHabit = try #require(updatedHabits.first)
        
        //confirm second object not created
        //Confirm updated values persist
        #expect(updatedHabits.count == 1)
        #expect(updatedHabit.name == "Updated name")
        #expect(updatedHabit.habitDescription == "Updated description")
    }
    
    @Test func createMultiplePersistedHabits() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let interactor = HabitEditorInteractor(context: container.mainContext)
        
        for i in 1...10 {
            try interactor.newHabit(name: "Test \(i)", description: "Test Description \(i)")
        }
        
        let habits = try container.mainContext.fetch(fetchDescriptor)
        
        #expect(habits.count == 10)
    }
}
