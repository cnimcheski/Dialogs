//
//  ConfirmationDialogViewModel.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/22/25.
//

import Foundation

public struct ConfirmationDialogViewModel: Identifiable {
    public let id: UUID
    let title: String
    let message: String
    let buttons: [DialogButtonViewModel]
    let onDismiss: (() -> Void)?
    
    public init(
        title: String = "",
        message: String = "Something went wrong. Please try again later.",
        buttons: [DialogButtonViewModel],
        onDismiss: (() -> Void)? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.message = message
        self.buttons = buttons
        self.onDismiss = onDismiss
    }
}

extension ConfirmationDialogViewModel: Equatable {
    public static func == (lhs: ConfirmationDialogViewModel, rhs: ConfirmationDialogViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Common Static Helpers

public extension ConfirmationDialogViewModel {
    static func cancelConfirmationDialog(
        title: String = "",
        message: String,
        buttons: [DialogButtonViewModel],
        cancelAction: DialogButtonAction = nil
    ) -> ConfirmationDialogViewModel {
        var buttons = buttons
        buttons.insert(.cancelButton(action: cancelAction), at: 0)
        return .init(
            title: title,
            message: message,
            buttons: buttons
        )
    }
}
