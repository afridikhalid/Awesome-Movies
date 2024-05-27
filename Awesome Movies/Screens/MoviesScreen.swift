//
//  MoviesScreen.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-20.
//

import SwiftUI

struct MoviesScreen: View {
    
    @Environment(\.managedObjectContext) private var context
    @StateObject private var modelView = MovieViewModel()
    
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: - Popular movies
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Popular")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                ForEach(modelView.popularMovies) { movie in
                                    NavigationLink {
                                        MovieDetailScreen(movieId: movie.id)
                                    } label: {
                                        MovieGridItemView(size: CGSize(width: geometry.size.width * 0.33, height: geometry.size.width * 0.43), movie: movie)
                                    }

                                }
                            }
                            
                        }
                        
                    } //: End Popular Movies VSTACK
                    .padding(.leading)
                    
                    // MARK: - Trending Movies
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Now Playing")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                ForEach(modelView.nowPlayingMovies) { movie in
                                    NavigationLink {
                                        MovieDetailScreen(movieId: movie.id)
                                    } label: {
                                        MovieGridItemView(size: CGSize(width: geometry.size.width * 0.5, height: geometry.size.width * 0.7), movie: movie)
                                        
                                    }
                                    
                                }
                            }
                            
                        }
                    } //: End of Now Playing VSTACK
                    .padding(.leading)
                    
                    // MARK: - Upcoming Movies
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Upcoming")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(modelView.upcomingMovies) { movie in
                                    NavigationLink {
                                        MovieDetailScreen(movieId: movie.id)
                                    } label: {
                                        MovieGridItemView(size: CGSize(width: geometry.size.width * 0.33, height: geometry.size.width * 0.43), movie: movie)
                                    }
                                }
                            }
                            
                        }
                    } //: End of Upcoming VSTACK
                    .padding(.leading)
                    
                    
                    // MARK: - Top rated Movies
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Top Rated")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                        ScrollView(.horizontal, showsIndicators: false) {
                            /// - NOTE:
                            /// Since we don't have caching in the app and we only uses a few movies to display
                            /// `LazyHGrid` or `LazyHStack` will be removed and recreated once it leaves the view area
                            /// that way they case the issue of re downloading the images
                            /// But for production with more data then we can use the LazyGrid or anywhere we don't keep downloading
                            /// more data. apple also recommends that we use Grid not LazyGrid's if we don't show a lot of data
                            ///
                            /// `From apple documentation`
                            /// You can achieve a similar layout using a Grid container. Unlike a lazy grid, which creates child views only when SwiftUI needs to display them, a regular grid creates all of its child views right away. This enables the grid to provide better support for cell spacing and alignment. Only use a lazy grid if profiling your app shows that a Grid view performs poorly because it tries to load too many views at once.
                            ///
                            /// To test try to scroll the Top Rated secion very fast compared to the rows above you will notice the difference
                            LazyHGrid(rows: [GridItem()], content: {
                                ForEach(modelView.topRatedMovies) { movie in
                                    NavigationLink {
                                        MovieDetailScreen(movieId: movie.id)
                                    } label: {
                                        MovieGridItemView(size: CGSize(width: geometry.size.width * 0.33, height: geometry.size.width * 0.43), movie: movie)
                                    }
                                }
                            })
                            
                        }
                    } //: End of Top Rated VSTACK
                    .padding(.leading)
                    .padding(.bottom)
                    
                    
                    
                }
                .navigationTitle("Movies")
            }
            .background(Color.colorBackground)
            .task {
                await modelView.fetchMovies()
            }
            
        }
        
    }
}

#Preview {
    NavigationStack {
        MoviesScreen()
    }
    
}

// MARK: - Swedish Preview
#Preview {
    NavigationStack {
        MoviesScreen()
    }
    .environment(\.locale, Locale(identifier: "sv"))
}
