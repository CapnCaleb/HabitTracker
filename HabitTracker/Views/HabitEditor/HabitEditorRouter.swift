//
//  HabitsRouter.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//

import Foundation

@MainActor
protocol HabitEditorRouterProtocol {
    func setDismissAction(_ action: @escaping () -> Void)
    func onComplete()
}


@MainActor
class HabitEditorRouter: HabitEditorRouterProtocol {
    var dismissAction: (() -> Void)?
    
    func setDismissAction(_ action: @escaping () -> Void) {
        dismissAction = action
    }
    
    func onComplete() {
        dismissAction?()
    }
}
