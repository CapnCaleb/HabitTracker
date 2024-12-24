//
//  MockError.swift
//  HabitTracker
//
//  Created by Caleb on 12/22/24.
//

import Foundation

enum MockError: Error, LocalizedError {
    case test
    
    public var errorDescription: String? {
        switch self {
        case .test:
            return NSLocalizedString("Test Error", comment: "My Error")
        }
    }
}
