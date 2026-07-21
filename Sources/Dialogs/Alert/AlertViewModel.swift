//
//  AlertViewModel.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/16/25.
//

import Foundation

public struct AlertViewModel: Identifiable {
    public let id: UUID
    let title: String
    let message: String
    let primaryButtonViewModel: DialogButtonViewModel
    let secondaryButtonViewModel: DialogButtonViewModel?
    let onDismiss: (() -> Void)?
    
    public init(
        title: String = "",
        message: String = "Something went wrong. Please try again later.",
        primaryButton: DialogButtonViewModel,
        secondaryButton: DialogButtonViewModel? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.message = message
        self.primaryButtonViewModel = primaryButton
        self.secondaryButtonViewModel = secondaryButton
        self.onDismiss = onDismiss
    }
}

extension AlertViewModel: Equatable {
    public static func == (lhs: AlertViewModel, rhs: AlertViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Shared Static Helpers

public extension AlertViewModel {
    static func generalErrorAlert(okAction: (() -> Void)? = nil) -> AlertViewModel {
        .init(
            message: "Sorry, there was an issue with your request. Please try again a bit later.",
            primaryButton: .okButton(action: okAction)
        )
    }
}
