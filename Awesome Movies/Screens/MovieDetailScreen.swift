//
//  MovieDetailScreen.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-24.
//

import SwiftUI

struct MovieDetailScreen: View {
    
    let movieId: Int
    @StateObject var viewModel: MovieDetailViewModel
    
    init(movieId: Int) {
        self.movieId = movieId
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .leading, content: {
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                    
                    // load image from backend
                    AsyncImage(url: viewModel.posterURL) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: geometry.size.width)
                        } else if phase.error != nil {
                            Color.red // error something happen handle error
                        } else {
                            // for placeholder uses simple the background color
                            Color.colorBackground
                        }
                    }
                    
                    
                    HStack {
                        Spacer()
                        CircularRatingView(value: viewModel.rating)
                            .frame(width: 65, height: 65)
                            .padding(.trailing)
                            
                    }
                    .offset(y: (geometry.size.width * 0.8) - 33)
                    .zIndex(1.0)
                    
                    // MARK: - Contents VStack
                    VStack(alignment: .leading) {
                        
                        Text(viewModel.title)
                            .font(.title)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundStyle(.colorLabel)
                            .padding(.top, 40)
                        
                        
                        HStack(alignment: .center) {
                            MovieDetailWidget(title: "year", value: viewModel.year, systemIcon: "calendar")
                            Spacer()
                            MovieDetailWidget(title: "duration", value: viewModel.runTime, systemIcon: "clock.arrow.2.circlepath")
                            Spacer()
                            MovieDetailWidget(title: "rating", value: viewModel.ratingString, systemIcon: "star")
                        }
                        .padding()
                        
                        Text("Overview")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.colorSecondaryLabel)
                            .padding()
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            Text(viewModel.overview)
                                
                            
                        } //: End of Scroll View
                        
                        
                        
                    } //: End of Contents VSTACK
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.colorBackground
                            .clipShape(CustomBezierPathShape())
                    )
                    .offset(y: geometry.size.width * 0.8)
                    
                    
                    
                })
                
                
                
            }) //:End of main VSTACK
            .ignoresSafeArea(.all, edges: .all)
            .background(
                .colorBackground
            )
        } //: End of Geometery Reader
    }
}

#Preview {
    MovieDetailScreen(movieId: 823464)
}
