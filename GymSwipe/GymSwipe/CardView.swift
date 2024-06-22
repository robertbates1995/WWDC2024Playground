//
//  CardView.swift
//  GymSwipe
//
//  Created by Robert Bates on 6/22/24.
//

import SwiftUI

struct CardView: View {
    @State private var offset = CGSize.zero
    let card: Card
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            VStack {
                Text(card.label)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 300, height: 500)
        .rotationEffect(.degrees(offset.width / 15.0))
        .offset(x: offset.width * 2)
        .opacity(2 - Double(abs(offset.width / 70)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset.width = gesture.translation.width / 1.5
                }
                .onEnded { _ in
                    if abs(offset.width) >= 100 {
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .animation(.bouncy, value: offset)
    }
}

#Preview {
    CardView(card: .example)
}
