//
//  HabitEditorError.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//

import Foundation

enum HabitEditorError: LocalizedError {
    case unableToSaveToDataStore(Error)
    
    public var errorDescription: String? {
        switch self {
        case .unableToSaveToDataStore(let error):
            return NSLocalizedString("Save or Update to Data Store failed", comment: "")
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .unableToSaveToDataStore(let error):
            return NSLocalizedString("Data Store implentation failed in HabitEditorInteractorProtocol implementation", comment: "")
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .unableToSaveToDataStore(let error):
            return NSLocalizedString("Check Data Store implementation and its connection with Data Store context.", comment: "")
        }
    }
}
