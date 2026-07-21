//
//  AlertViewModifier.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/16/25.
//

import SwiftUI

public extension View {
    /// Presents an alert to the user.
    ///
    /// Use this method when you need to show an alert using `AlertViewModel` binding.
    ///
    /// ```
    /// struct ConfirmImportAlert: View {
    ///     @State var alertViewModel: AlertViewModel?
    ///
    ///     var body: some View {
    ///         Button("Show Alert") {
    ///             alertViewModel = AlertViewModel(...)
    ///         }
    ///         .alert(viewModel: $alertViewModel)
    ///     }
    /// }
    /// ```
    @ViewBuilder
    func alert(viewModel: Binding<AlertViewModel?>) -> some View {
        modifier(AlertViewModifier(viewModel: viewModel))
    }
}

/// A view modifier that presents an alert using an `AlertViewModel`
private struct AlertViewModifier: ViewModifier {
    @Binding private var viewModel: AlertViewModel?
    @State private var isShown = false
    
    init(viewModel: Binding<AlertViewModel?>) {
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
        
        let alertViewModel = viewModel
        return content.alert(
            Text(alertViewModel?.title ?? ""),
            isPresented: binding
        ) {
            AlertButton(viewModel: alertViewModel?.primaryButtonViewModel)
            AlertButton(viewModel: alertViewModel?.secondaryButtonViewModel)
        } message: {
            Text(alertViewModel?.message ?? "")
        }
    }
}

// MARK: - Private Button extension

private struct AlertButton: View {
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
