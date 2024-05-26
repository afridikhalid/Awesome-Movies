//
//  CustomBezierPathShape.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-25.
//

import SwiftUI

struct CustomBezierPathShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

#Preview {
    CustomBezierPathShape()
        .padding()
}
