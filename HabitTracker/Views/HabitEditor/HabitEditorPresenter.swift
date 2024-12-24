//
//  HabitEditorPresenterProtocol.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//


import Foundation
import SwiftData

@MainActor
protocol HabitEditorPresenterProtocol: ObservableObject {
    var name: String { get set }
    var description: String { get set }
    var isPresentingAlert: Bool { get set }
    
    var habit: Habit? { get }
    var error: LocalizedError? { get set }
    var saveActionTitle: String { get }
    var navigationTitle: String { get }
    
    var router: HabitEditorRouterProtocol { get }
    var interactor: HabitEditorInteractorProtocol { get }
}

@MainActor
class HabitEditorPresenter: HabitEditorPresenterProtocol {
    @Published var name: String
    @Published var description: String
    @Published var isPresentingAlert: Bool = false
    
    let habit: Habit?
    var error: LocalizedError?
    let saveActionTitle: String
    let navigationTitle: String
    
    let router: HabitEditorRouterProtocol
    let interactor: HabitEditorInteractorProtocol
    
    init(habit: Habit?, context: ModelContext) {
        self.name = habit?.name ?? ""
        self.description = habit?.habitDescription ?? ""
        
        saveActionTitle = HabitEditorPresenter.generateSaveActionTitle(habit)
        navigationTitle = HabitEditorPresenter.generateNavigationTitle(habit)
        
        self.habit = habit
        self.router = HabitEditorRouter()
        self.interactor = HabitEditorInteractor(context: context)
    }
    
    init(habit: Habit?, router: HabitEditorRouterProtocol, interactor: HabitEditorInteractorProtocol) {
        self.name = habit?.name ?? ""
        self.description = habit?.habitDescription ?? ""
        
        saveActionTitle = HabitEditorPresenter.generateSaveActionTitle(habit)
        navigationTitle = HabitEditorPresenter.generateNavigationTitle(habit)
        
        self.habit = habit
        self.router = router
        self.interactor = interactor
    }
    
    
    static func isNewHabit(_ habit: Habit?) -> Bool {
        habit == nil
    }
    
    static func generateNavigationTitle(_ habit: Habit?) -> String {
        isNewHabit(habit) ? "New Habit" : "Edit Habit"
    }
    
    static func generateSaveActionTitle(_ habit: Habit?) -> String {
        isNewHabit(habit) ? "Save" : "Update"
    }
    
    func saveAction() {
        do {
            if let habit {
                try interactor.update(habit: habit, name: name, description: description)
            } else {
                try interactor.newHabit(name: name, description: description)
            }
            router.onComplete()
        } catch {
            handleError(HabitEditorError.unableToSaveToDataStore(error))
        }
    }
    
    func cancelAction() {
        router.onComplete()
    }
    
    func handleError(_ error: HabitEditorError) {
        self.error = error
        self.isPresentingAlert = true
    }
    
    func dismissAlertAction() {
        isPresentingAlert = false
        self.error = nil
    }
}
