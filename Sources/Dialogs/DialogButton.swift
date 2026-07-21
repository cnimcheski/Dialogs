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
            Button(
                viewModel.title,
                role: viewModel.type.role,
                action: viewModel.action ?? {}
            )
        }
    }
}
