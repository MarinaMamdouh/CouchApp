//
//  MovieGridCell.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import SwiftUI


struct MovieGridCell: View {
    @StateObject var viewModel: MovieGridCellViewModel
    @State var opacity = 1.0
    private let animation = Animation.easeInOut(duration: 1)
    
    init(movie: MovieModel){
        _viewModel = StateObject(wrappedValue:  MovieGridCellViewModel(movieModel: movie))
    }
    
    var body: some View {
        VStack {
            
            if viewModel.isLoading{
                movieTextBox
            }
            
            movieImage
        }
        
    }
    
    
}

extension MovieGridCell{
    
    var movieTextBox: some View{
        Text(viewModel.movie.title)
            .font(.title2)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.theme.primary)
            .padding()
            .frame(maxWidth: Constants.ImageSizes.maxPosterSize.width)
            .frame(maxHeight: Constants.ImageSizes.maxPosterSize.height)
            .aspectRatio(Constants.ImageSizes.posterAspectRatio, contentMode: .fill)
            .background(Color.theme.secondary)
            .cornerRadius(10)
            .opacity(opacity)
            .animation(animation.repeat(while: viewModel.isLoading))
            .onAppear {
                withAnimation{
                    opacity = 0.5
                }
            }
    }
    
    var movieImage: some View{
        VStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
        }
    }
}

struct MovieGridCell_Preview: PreviewProvider {
    static var previews: some View {
        MovieGridCell(movie: MovieModel(id: 1, originalTitle: "MyMovie", title: "My Movie: The part Two", posterPath: "/mIrShVoYwmN2fBsEsNcxvCPVAs5.jpg"))
            .previewLayout(.sizeThatFits)
    }
}

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
