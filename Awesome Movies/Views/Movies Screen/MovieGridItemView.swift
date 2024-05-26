//
//  MovieGridItemView.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-22.
//

import SwiftUI

/// Movie Grid Item View represent each movie / TV shows in Movies view
struct MovieGridItemView: View {
    
    let size: CGSize
    let movie: Movie
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                
                // NOTE: this The AsyncImage is ok for the moment but for production versions we have to take care of Caching the images
                // Otherwise when there will be a lot of movies / TV shows with alot
                AsyncImage(url: movie.posterImageURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: .colorLabel, radius: 1.0)
                    } else if phase.error != nil {
                        // we can provide different image for error but i have used a color instead of image or view
                        Color.red
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: .colorSecondaryLabel, radius: 4.0)
                    } else {
                        // Here we use a place holder. I simply used the blue color but we can add an image instead color
                        Color.blue
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: .colorSecondaryLabel, radius: 4.0)
                    }
                }
                
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .padding(.all, 1)
                        .foregroundStyle(.white)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    Text(String(format: "%0.1f", movie.vote_average))
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .background(.gray.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .offset(x: -4, y: -4)
                
            }
            
            Text(movie.title)
                .font(.caption)
                .fontWeight(.bold)
                .frame(maxWidth: size.width - 16, alignment: .leading)
                .foregroundStyle(.colorLabel)
                .padding(.top, -4)
                .padding(.leading, 6)
        }
        
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MovieGridItemView(size: CGSize(width: 220, height: 160), movie: Movie.dummeMovie)
        .padding()
}
