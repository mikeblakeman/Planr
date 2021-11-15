//
//  WorkBlockView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/7/21.
//

import SwiftUI

/// A view that represents a block of work.
///
/// This view has the name of the feature, the remaining sprint points, and an indicator to denote that this is the last
/// sprint that the feature will be worked on.
struct WorkBlockView: View {

    private var workBlock: WorkBlock

    init(workBlock: WorkBlock) {
        self.workBlock = workBlock
    }

    var body: some View {
        HStack {
            Text(self.workBlock.name).padding()
                .font(.system(size: 14))
                .foregroundColor(.white)
            Spacer()
            HStack {
                if self.workBlock.isFinalSprint {
                    Image("Task")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 22, height: 22)
                }
                Text("\(self.workBlock.pointValue)")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }.padding(.trailing, 10)
        }.background(self.workBlock.color)
        .cornerRadius(10)
    }
}

struct WorkBlockView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(getDemoWorkBlocks(), id: \.self) { workBlock in
            WorkBlockView(workBlock: workBlock)
        }
    }
}
