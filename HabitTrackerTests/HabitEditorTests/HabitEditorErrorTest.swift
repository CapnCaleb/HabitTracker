//
//  HabitEditorErrorTest.swift
//  HabitTracker
//
//  Created by Caleb on 12/22/24.
//

import Foundation
import Testing

@testable import HabitTracker

struct HabitEditorErrorTest {
    @Test
    func unableToSaveToDataStoreError() throws {
        let error = HabitEditorError.unableToSaveToDataStore(MockError.test)
        #expect(error.errorDescription == "Save or Update to Data Store failed")
        #expect(error.failureReason == "Data Store implentation failed in HabitEditorInteractorProtocol implementation")
        #expect(error.recoverySuggestion == "Check Data Store implementation and its connection with Data Store context.")
    }
}
