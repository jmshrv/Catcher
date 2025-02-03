//
//  ErrorChip.swift
//  Catcher
//
//  Created by James Harvey on 03/02/2025.
//

import SwiftUI

struct ErrorChip: View {
    let error: CatcherError
    
    @Binding var shownError: CatcherError?
    
    var body: some View {
        Button(
            "An error has occured.",
            systemImage: "exclamationmark.circle.fill") {
                shownError = error
            }
            .buttonStyle(ErrorButtonStyle())
    }
}

#Preview {
    ErrorChip(
        error: .init(
            callStack: Thread.callStackSymbols,
            dateOccurred: .now,
            error: PreviewError.example(.now)
        ),
        shownError: .constant(nil)
    )
}
