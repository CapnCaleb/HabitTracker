//
//  HabitEditorPresenterTests.swift
//  HabitTracker
//
//  Created by Caleb on 12/22/24.
//

import Foundation
import SwiftData
import Testing

@testable import HabitTracker

@MainActor
struct HabitEditorPresenterTests {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let fetchDescription = FetchDescriptor<Habit>()
    
    @Test func newHabitWithEmptyContainer() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let context = container.mainContext
        
        let presenter = HabitEditorPresenter(habit: nil, context: context)
        
        #expect(presenter.name == "")
        #expect(presenter.description == "")
        #expect(presenter.error == nil)
        #expect(presenter.isPresentingAlert == false)
        #expect(presenter.saveActionTitle == "Save")
        #expect(presenter.navigationTitle == "New Habit")
        #expect(presenter.habit == nil)
    }
    
    
    @Test func editingHabitEditor() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let context = container.mainContext
        let testName = "Test Name"
        let testDescription = "Test Description"
        let testHabit = Habit(name: testName, habitDescription: testDescription)
        context.insert(testHabit)
        if context.hasChanges { try context.save() }
        
        let fetchedHabit = try #require(context.fetch(fetchDescription).first)
        
        let presenter = HabitEditorPresenter(habit: fetchedHabit, context: context)
        
        #expect(presenter.name == testName)
        #expect(presenter.description == testDescription)
        #expect(presenter.error == nil)
        #expect(presenter.isPresentingAlert == false)
        #expect(presenter.saveActionTitle == "Update")
        #expect(presenter.navigationTitle == "Edit Habit")
        #expect(presenter.habit == fetchedHabit)
    }
    
    @Test func nilHabitStaticMethodOutput() throws {
        #expect(HabitEditorPresenter.isNewHabit(nil) == true)
        #expect(HabitEditorPresenter.generateNavigationTitle(nil) == "New Habit")
        #expect(HabitEditorPresenter.generateSaveActionTitle(nil) == "Save")
    }
    
    @Test func habitStaticMethodOutput() throws {
        let testHabit = Habit(name: "Test Name", habitDescription: "Test Description")
        #expect(HabitEditorPresenter.isNewHabit(testHabit) == false)
        #expect(HabitEditorPresenter.generateNavigationTitle(testHabit) == "Edit Habit")
        #expect(HabitEditorPresenter.generateSaveActionTitle(testHabit) == "Update")
    }
    
    @Test func nilHabitSaveActionContextOutput() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let context = container.mainContext
        
        let presenter = HabitEditorPresenter(habit: nil, context: context)
        
        let newName = "New Name"
        let newDescription = "New Description"
        
        presenter.name = newName
        presenter.description = newDescription
        
        presenter.saveAction()
        
        let fetchedHabit = try #require(context.fetch(fetchDescription).first)
        
        #expect(fetchedHabit.name == newName)
        #expect(fetchedHabit.habitDescription == newDescription)
    }
    
    @Test func habitSaveActionContextOutput() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let context = container.mainContext
        let testName = "Test Name"
        let testDescription = "Test Description"
        let testHabit = Habit(name: testName, habitDescription: testDescription)
        context.insert(testHabit)
        if context.hasChanges { try context.save() }
        
        let fetchedHabit = try #require(context.fetch(fetchDescription).first)
        
        let presenter = HabitEditorPresenter(habit: fetchedHabit, context: context)
        
        let updatedName = "Updated Name"
        let updatedDescription = "Updated Description"
        presenter.name = updatedName
        presenter.description = updatedDescription
        presenter.saveAction()
        
        let updatedHabit = try #require(context.fetch(fetchDescription).first)
        #expect(updatedHabit.name == updatedName)
        #expect(updatedHabit.habitDescription == updatedDescription)
    }
    
    @Test func dismissAlertAction() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let context = container.mainContext
        
        let presenter = HabitEditorPresenter(habit: nil, context: context)
        
        presenter.handleError(HabitEditorError.unableToSaveToDataStore(MockError.test))
        
        #expect(presenter.error != nil)
        #expect(presenter.isPresentingAlert == true)
        
        presenter.dismissAlertAction()
        
        #expect(presenter.error == nil)
        #expect(presenter.isPresentingAlert == false)
    }
    
    @Test func handleError() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let context = container.mainContext
        
        let presenter = HabitEditorPresenter(habit: nil, context: context)
        
        presenter.handleError(HabitEditorError.unableToSaveToDataStore(MockError.test))
        
        #expect(presenter.error != nil)
        #expect(presenter.isPresentingAlert == true)
    }
    
    @Test func cancelAction() throws {
        let container = try ModelContainer(for: Habit.self, configurations: config)
        let context = container.mainContext
        
        let presenter = HabitEditorPresenter(habit: nil, context: context)
        
        presenter.cancelAction()
        
        #expect(true)
    }
    
    @Test func throwingInteractor() throws {
        let router = HabitEditorRouter()
        let interactor = MockThrowingHabitEditorInteractor()
        let presenter = HabitEditorPresenter(habit: nil, router: router, interactor: interactor)
        presenter.saveAction()
        
        #expect(presenter.error != nil)
        #expect(presenter.isPresentingAlert == true)
        
    }
}

extension HabitEditorPresenterTests {
    class MockThrowingHabitEditorInteractor: HabitEditorInteractorProtocol {
        func newHabit(name: String, description: String) throws {
            throw MockError.test
        }
        
        func update(habit: HabitTracker.Habit, name: String, description: String) throws {
            throw MockError.test
        }
    }
}


