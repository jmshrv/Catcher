//
//  CatchScope.swift
//  Catcher
//
//  Created by James Harvey on 31/01/2025.
//

import Foundation
import OrderedCollections
import SwiftUI

@Observable
@MainActor
public final class CatchScope {
    /// The errors to show in the UI. We use dates as keys so that the earliest error is shown
    /// first and so that we can easily remove items (removing by index would feel flakey).
    private(set) var errors: OrderedDictionary<Date, CatcherError> = [:]
    
    private let errorAnimation = Animation.spring
    
    private let removeDelay = Duration.seconds(3)
    
    init() {}
    
    public func withCatchScope(_ throwing: @escaping () throws -> Void) {
        func asyncWrapper() async throws {
            try throwing()
        }
        
        Task {
            await withCatchScopeAsync(asyncWrapper)
        }
    }
    
    public func withCatchScopeAsync(_ throwing: () async throws -> Void) async {
        do {
            try await throwing()
        } catch {
            let dateOccurred = Date()
            let stack = Thread.callStackSymbols
            
            withAnimation(errorAnimation) {
                errors[dateOccurred] = .init(
                    callStack: stack,
                    dateOccurred: dateOccurred,
                    error: error
                )
            }
            
            // This task handles removing the errors after a certain amount of time so that the UI
            // can cycle through errors by showing errors.first.
            Task {
                // We multiply removeDelay by the amount of errors so that errors get "cycled" in 3
                // second increments. For example, if there are 3 errors in the list, we want the
                // 3rd one to be removed 9 seconds after it is inserted.
                try? await Task.sleep(for: removeDelay * errors.count)
                
                let _ = withAnimation(errorAnimation) {
                    errors.removeValue(forKey: dateOccurred)
                }
            }
        }
    }
    
    // func popError() -> (any Error)? {
    //     if errors.isEmpty {
    //         return nil
    //     }
    //     
    //     return withAnimation(.spring) {
    //         return errors.removeFirst()
    //     }
    // }
}
