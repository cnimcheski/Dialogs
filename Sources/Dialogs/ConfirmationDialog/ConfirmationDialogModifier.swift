//
//  ConfirmationDialogModifier.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/22/25.
//

import SwiftUI

public extension View {
    func confirmationDialog(
        viewModel: Binding<ConfirmationDialogViewModel?>
    ) -> some View {
        modifier(ConfirmationDialogModifier(viewModel: viewModel))
    }
}

private struct ConfirmationDialogModifier: ViewModifier {
    @Binding private var viewModel: ConfirmationDialogViewModel?
    @State private var isShown = false
    
    init(viewModel: Binding<ConfirmationDialogViewModel?>) {
        _viewModel = viewModel
    }
    
    func body(content: Content) -> some View {
        let binding = Binding<Bool>(
            get: {
                let shouldShow = viewModel != nil
                if shouldShow, !isShown {
                    Task {
                        isShown = true
                    }
                }
                return shouldShow
            },
            set: { (newValue: Bool) in
                if !newValue {
                    viewModel?.onDismiss?()
                    viewModel = nil
                    isShown = false
                }
            }
        )
        
        let confirmationDialogViewModel = viewModel
        return content.confirmationDialog(
            confirmationDialogViewModel?.title ?? "",
            isPresented: binding,
            titleVisibility: confirmationDialogViewModel?.title == "" ? .hidden : .visible
        ) {
            ForEach(confirmationDialogViewModel?.buttons ?? []) { viewModel in
                DialogButton(viewModel: viewModel)
            }
        } message: {
            Text(confirmationDialogViewModel?.message ?? "")
        }
    }
}

// MARK: - Private Button extension

private struct ConfirmationDialogButton: View {
    let viewModel: DialogButtonViewModel?
    
    var body: some View {
        if let viewModel {
            Button(
                viewModel.title,
                role: viewModel.type.role,
                action: viewModel.action ?? {}
            )
        }
    }
}
