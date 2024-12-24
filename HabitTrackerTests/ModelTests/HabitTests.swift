//
//  HabitTests.swift
//  HabitTracker
//
//  Created by Caleb on 12/23/24.
//

import Foundation
import Testing
@testable import HabitTracker

struct HabitTests {
    let testname = "Test Name"
    let testDescription = "Test Description"
    
    @Test func testInitiliazer() {
        let habit = Habit(name: testname, habitDescription: testDescription)
        
        #expect(habit.name == testname)
        #expect(habit.habitDescription == testDescription)
        #expect(habit.created == Calendar.current.startOfDay(for: .now))
        #expect(habit.updated == Calendar.current.startOfDay(for: .now))
        #expect(habit.isArchived == false)
        #expect(habit.endDate == nil)
    }
    
    @Test func testArchive() {
        let habit = Habit(name: testname, habitDescription: testDescription)
        habit.endDate = Calendar.current.startOfDay(for: .now)
        
        #expect(habit.isArchived == true)
    }
    
    @Test func testEquatable() {
        let habit1 = Habit(name: testname, habitDescription: testDescription)
        let habit2 = Habit(name: testname, habitDescription: testDescription)
        let copiedHabit1 = habit1
        
        #expect(habit1 == copiedHabit1)
        #expect(habit1 != habit2)
    }
}
