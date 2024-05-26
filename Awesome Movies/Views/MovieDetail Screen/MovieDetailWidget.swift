//
//  MovieDetailWidget.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import SwiftUI

struct MovieDetailWidget: View {
    
    let title: String
    let value: String
    let systemIcon: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Text(value)
                    .font(.headline)
                    .foregroundStyle(.colorLabel)
                Image(systemName: systemIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15)
                    .foregroundColor(.orange)
                
            }
            Text(title.capitalized)
                .font(.footnote)
                .foregroundStyle(.colorSecondaryLabel)
        }
    }
}

#Preview {
    MovieDetailWidget(title: "Year", value: "2015", systemIcon: "calendar")
}
