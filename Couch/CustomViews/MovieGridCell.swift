//
//  MovieGridCell.swift
//  Couch
//
//  Created by Marina on 06/09/2022.
//

import SwiftUI


struct MovieGridCell: View {
    @State var movie: MovieModel
    let defaultImage = UIImage(named: "DefaultImage")!
    var body: some View {
        VStack {
            Text(movie.title)
            Image(uiImage: defaultImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                
            
        }.background(Color.blue)
            .cornerRadius(10)
    }
}

struct MovieGridCell_Preview: PreviewProvider {
    static var previews: some View {
       MovieGridCell(movie: MovieModel(id: 1, originalTitle: "MyMovie", title: "MyMovie", posterPath: ""))
            .previewLayout(.sizeThatFits)
    }
}
