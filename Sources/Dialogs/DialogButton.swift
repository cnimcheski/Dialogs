//
//  DialogButton.swift
//  climbto350
//
//  Created by Steve Nimcheski on 7/22/25.
//

import SwiftUI

struct DialogButton: View {
    let viewModel: DialogButtonViewModel?
    
    var body: some View {
        if let viewModel {
            switch viewModel.type {
            case .default,
                .cancel,
                .destructive:
                Button(
                    viewModel.title,
                    role: viewModel.type.role,
                    action: viewModel.action ?? {}
                )
            case let .share(viewModel):
                ShareLink(
                    item: viewModel.item,
                    subject: Text(viewModel.subject),
                    message: viewModel.message.map { Text($0) }
                )
            }
        }
    }
}
