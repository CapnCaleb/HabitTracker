//
//  HabitEditorRouterTests.swift
//  HabitTracker
//
//  Created by Caleb on 12/22/24.
//

import Foundation
import Testing

@testable import HabitTracker

@MainActor
struct HabitEditorRouterTests {
    @Test
    func setDismissAction() throws {
        let router = HabitEditorRouter()
        let dismissAction: () -> Void = { }
        router.setDismissAction {
            dismissAction()
        }
        #expect(router.dismissAction != nil)
    }
    
    @Test
    func performDismissAction() throws {
        let router = HabitEditorRouter()
        var dismissActionCalled: Bool = false
        let dismissAction: () -> Void = { dismissActionCalled = true }
        router.setDismissAction {
            dismissAction()
        }
        router.onComplete()
        #expect(dismissActionCalled == true)
    }
    
    @Test
    func performDismissActionWithNoAction() throws {
        let router = HabitEditorRouter()
        router.onComplete()
    }
}
