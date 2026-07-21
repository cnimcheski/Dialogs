//
//  DialogButtonViewModel.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/22/25.
//

import SwiftUI

public typealias DialogButtonAction = (() -> Void)?

public enum DialogButtonType {
    case `default`
    case cancel
    case destructive
    
    var role: ButtonRole? {
        switch self {
        case .default:
            nil
        case .cancel:
            .cancel
        case .destructive:
            .destructive
        }
    }
}

public struct DialogButtonViewModel: Identifiable {
    public let id = UUID()
    let title: String
    let type: DialogButtonType
    let action: DialogButtonAction
    
    public init(
        title: String,
        type: DialogButtonType = .default,
        action: DialogButtonAction = nil
    ) {
        self.title = title
        self.type = type
        self.action = action
    }
}

// MARK: - Default Static Buttons

public extension DialogButtonViewModel {
    static func cancelButton(
        action: DialogButtonAction = nil
    ) -> DialogButtonViewModel {
        .init(
            title: "Cancel",
            type: .cancel,
            action: action
        )
    }
    
    static func okButton(
        action: DialogButtonAction = nil
    ) -> DialogButtonViewModel {
        .init(
            title: "Ok",
            type: .cancel,
            action: action
        )
    }
}
