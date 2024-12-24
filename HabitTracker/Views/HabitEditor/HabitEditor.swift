//
//  HabitEditor.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//


import SwiftData
import SwiftUI

struct HabitEditor: View {
    @ObservedObject private var presenter: HabitEditorPresenter
    @Environment(\.dismiss) private var dismiss
    
    init(habit: Habit? = nil, context: ModelContext) {
        self.presenter = HabitEditorPresenter(habit: habit, context: context)
    }
    
    init(presenter: HabitEditorPresenter) {
        self.presenter = presenter
    }

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $presenter.name, prompt: Text("Enter Habit Name"), axis: .horizontal)
                TextField("Description", text: $presenter.description, prompt: Text("Enter Description"), axis: .vertical)
            } footer: {
                Text("Habits create Tasks daily for you to complete.")
            }
        }
        .navigationTitle(presenter.navigationTitle)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(presenter.saveActionTitle) {
                    presenter.saveAction()
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel", role: .cancel) {
                    presenter.cancelAction()
                }
            }
            
        }
        .onAppear {
            presenter.router.setDismissAction {
                dismiss()
            }
        }
        .alert(presenter.error?.errorDescription ?? "", isPresented: $presenter.isPresentingAlert) {
            Button("Ok") {
                presenter.dismissAlertAction()
            }
        } message: {
            Text(presenter.error?.failureReason ?? "")
        }

    }
}

#Preview(body: { 
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Habit.self, configurations: config)
    let testHabit = Habit(name: "Test Habit", habitDescription: "Test Description")
    container.mainContext.insert(testHabit)
    
//    return NavigationStack {
//        HabitEditor(context: container.mainContext, habit: testHabit)
//            .modelContainer(container)
//    }
    
    return NavigationStack {
        HabitEditor(context: container.mainContext)
    }
})
