//
//  PlatformSelectionViewModel.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import Foundation

class PlatformSelectionViewModel: ObservableObject {
    @Published var platforms: [PlatformSelectionModel] = [
        PlatformSelectionModel(modelId: 0, platformType: .ios, isActive: false),
        PlatformSelectionModel(modelId: 1, platformType: .android, isActive: false),
        PlatformSelectionModel(modelId: 2, platformType: .cocoas2dx, isActive: false)
    ] {
        didSet {
            anySelected = platforms.contains(where: { $0.isActive })
        }
    }

    @Published var anySelected: Bool = false
}

struct PlatformSelectionModel: Hashable {
    let modelId: Int
    let platformType: PlatformType
    let isActive: Bool

    init(modelId: Int, platformType: PlatformType, isActive: Bool) {
        self.modelId = modelId
        self.platformType = platformType
        self.isActive = isActive
    }
}
