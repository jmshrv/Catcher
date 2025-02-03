//
//  ErrorSheet.swift
//  Catcher
//
//  Created by James Harvey on 03/02/2025.
//

import SwiftUI

struct ErrorSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let error: CatcherError
    
    var body: some View {
        NavigationStack {
            List {
                Section("Description") {
                    Text("\(error.error)")
                        .textSelection(.enabled)
                }
                Section("Call Stack") {
                    ForEach(error.callStack, id: \.self) { stackFrame in
                        Text(stackFrame)
                            .monospaced()
                            .textSelection(.enabled)
                    }
                }
            }
            .navigationTitle("Error")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    Text("Hello!")
        .sheet(isPresented: .constant(true)) {
            ErrorSheet(
                error: .init(
                    callStack: Thread.callStackSymbols,
                    dateOccurred: .now,
                    error: PreviewError.example(.now)
                )
            )
        }
}
