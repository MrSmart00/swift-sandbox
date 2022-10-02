//
//  IndicatorView.swift
//  App
//
//  Created by 日野森寛也 on 2022/10/02.
//

import SwiftUI

struct IndicatorView: View {
    @State var isAnimating = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.6)
            .stroke(
                AngularGradient(
                    gradient: .init(colors: [.gray, .white]),
                    center: .center
                ),
                style: StrokeStyle(
                    lineWidth: 8,
                    lineCap: .round,
                    dash: [0.1, 16],
                    dashPhase: 8
                )
            )
            .frame(
                width: 48,
                height: 48
            )
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(
                .linear(duration: 1)
                .repeatForever(autoreverses: false)
            )
            .onAppear() {
                isAnimating.toggle()
            }
    }

}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView()
            .previewLayout(.sizeThatFits)
    }
}
