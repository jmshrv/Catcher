//
//  CatcherError.swift
//  Catcher
//
//  Created by James Harvey on 03/02/2025.
//

import Foundation

/// A wrapper around `any Error` with Identifiable conformance and stack trace info.
struct CatcherError: Identifiable {
    let id = UUID()
    
    let callStack: [String]
    
    let dateOccurred: Date
    
    let error: any Error
}
