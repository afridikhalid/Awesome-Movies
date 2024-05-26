//
//  SavedMovieCell.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-26.
//

import SwiftUI


struct SavedMovieCell: View {
    
    
    let movie: SavedMovie
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 20) {
            
            HStack {
                // load image from backend
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 90, maxHeight: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else if phase.error != nil {
                        Color.red // error something happen handle error
                            .frame(maxWidth: 90, maxHeight: 140)
                    } else {
                        // for placeholder uses simple the background color
                        Color.colorBackground
                            .frame(maxWidth: 90, maxHeight: 140)
                    }
                }
                .padding(.trailing, 12)
                
                
                VStack(alignment: .leading) {
                    Text(movie.title ?? " ")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                    
                    Text(movie.overview ?? " ")
                        .font(.footnote)
                        .lineLimit(2)
                        .foregroundStyle(.colorSecondaryLabel)
                    
                    Spacer()
                    HStack(alignment: .center) {
                        
                        MovieDetailWidget(title: "year", value: movie.release_date?.toYear ?? " - ", systemIcon: "calendar")
                        Spacer()
                        
                        MovieDetailWidget(title: "rating", value: String(format: "%0.1f", movie.vote_average), systemIcon: "star")
                    }
                    
                    
                }
                
            }
            .padding()
            .background(
                .colorCustomBlue
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .colorSecondaryLabel, radius: 1)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.clear)
        
    }
}

#Preview {
    let context = CoreDataProvider(inMemory: true).context
    return SavedMovieCell(movie: SavedMovie.dummeSavedMovie(for: context))
}
