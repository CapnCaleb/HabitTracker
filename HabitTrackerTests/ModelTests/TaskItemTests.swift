//
//  TaskItemTests.swift
//  HabitTracker
//
//  Created by Caleb on 12/23/24.
//

import Foundation
import Testing

@testable import HabitTracker

struct TaskItemTests {
    let taskItemName = "Test Task Item"
    let testNote = "Test Note"
    
    @Test func TaskItemInitializer() {
        let taskItem = TaskItem(name: taskItemName)
        
        #expect(taskItem.name == taskItemName)
        #expect(taskItem.note == "")
        #expect(taskItem.created == Calendar.current.startOfDay(for: .now))
        #expect(taskItem.completed == nil)
    }
    
    @Test func markTaskItemCompleted() {
        let taskItem = TaskItem(name: taskItemName)
        taskItem.markComplete()
        
        #expect(taskItem.isComplete == true)
    }
    
    @Test func editNameOfTaskItem() {
        let taskItem = TaskItem(name: taskItemName)
        let updatedName = "Updated Name"
        taskItem.name = updatedName
        
        #expect(taskItem.name == updatedName)
    }
    
    @Test func addNoteToTaskItem() {
        let taskItem = TaskItem(name: taskItemName)
        taskItem.note = testNote
        
        #expect(taskItem.note == testNote)
    }
}
