//
//  CatchHandler.swift
//  Catcher
//
//  Created by James Harvey on 31/01/2025.
//

import SwiftUI

struct CatchHandler: ViewModifier {
    @State private var scope: CatchScope
    
    @State private var shownError: CatcherError?
    
    public init(scope: CatchScope = CatchScope()) {
        self.scope = scope
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
                .frame(maxHeight: .infinity)
                .environment(scope)
            
            if let error = scope.errors.values.first {
                ErrorChip(error: error, shownError: $shownError)
                    .transition(.blurReplace)
            }
        }
        .sheet(item: $shownError) { error in
            ErrorSheet(error: error)
        }
    }
}

#Preview {
    @Previewable @State var scope = CatchScope()
    
    Button("Throw an error!") {
        scope.withCatchScope {
            throw PreviewError.example(.now)
        }
    }
    .modifier(CatchHandler(scope: scope))
}
