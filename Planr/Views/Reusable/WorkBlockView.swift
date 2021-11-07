//
//  WorkBlockView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/7/21.
//

import SwiftUI

struct WorkBlockView: View {

    private var name: String
    private var points: Int
    private var color: Color
    private var isFinalSprint: Bool

    init(name: String, points: Int, color: Color, isFinalSprint: Bool) {
        self.name = name
        self.points = points
        self.color = color
        self.isFinalSprint = isFinalSprint
    }

    var body: some View {
        HStack {
            Text(self.name).padding()
                .font(.system(size: 22))
                .foregroundColor(.white)
            Spacer()
            HStack {
                if isFinalSprint {
                    Image(systemName: "calendar.badge.plus")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                }
                Text("\(points)").padding(.leading, 10)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
            }.padding()
        }.frame(minHeight: 50)
        .background(self.color)
    }
}

struct WorkBlockView_Previews: PreviewProvider {
    static var previews: some View {
        WorkBlockView(name: "Family Accounts",
                      points: 8,
                      color: .red,
                      isFinalSprint: true)

        WorkBlockView(name: "Device Setup",
                      points: 16,
                      color: .purple,
                      isFinalSprint: false)
    }
}
