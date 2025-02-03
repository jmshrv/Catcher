//
//  CatchScopePreview.swift
//  Catcher
//
//  Created by James Harvey on 31/01/2025.
//

import SwiftUI

struct CatchScopePreview: PreviewModifier {
    static func makeSharedContext() async throws -> CatchScope {
        return CatchScope()
    }
    
    func body(content: Content, context: CatchScope) -> some View {
        content
            .environment(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var catchScope: Self = .modifier(CatchScopePreview())
}
