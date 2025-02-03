//
//  ErrorButtonStyle.swift
//  Catcher
//
//  Created by James Harvey on 03/02/2025.
//

import SwiftUI

struct ErrorLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .imageScale(.large)
            configuration.title
        }
    }
}

struct ErrorButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(ErrorLabelStyle())
            .padding()
            .background(.quaternary, in: Capsule())
            .overlay(
                Capsule()
                    .stroke(Material.ultraThin, lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.5 : 1)
            .foregroundStyle(.red)
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "exclamationmark.circle.fill")
    }
    .buttonStyle(ErrorButtonStyle())
}
