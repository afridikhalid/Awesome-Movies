//
//  CircularRatingView.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-25.
//

import SwiftUI

/// This view
struct CircularRatingView: View {
    
    let value: Double
    
    var body: some View {
        
        // MARK: - Outer ZSTACK
        ZStack {
            Circle()
                .fill(.black)
            
            // MARK: - Iner ZSTACK
            ZStack {
                Circle()
                    .stroke(
                        .green.opacity(0.4),
                        lineWidth: 6.0
                    )
                    .padding(.all, 4)
                
                Circle()
                    .fill(.green.opacity(0.2))
                
                Circle()
                    .trim(from: 0, to: CGFloat(value / 10.0))
                    .stroke(
                        .green,
                        style: StrokeStyle (
                            lineWidth: 4,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: value)
                    .padding(.all, 4)
                    
            } //: Iner Circles
            .padding(.all, 2)
            
            HStack(alignment: .top, spacing: 2) {
                Text(String(format: "%.0f", value * 10))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    
                Text("%")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .padding(.leading, 4)
            
        } //: Outer ZSTACK
        .shadow(radius: 10)
    }
}

#Preview {
    CircularRatingView(value: 0)
}
