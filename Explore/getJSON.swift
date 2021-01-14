//
//  File.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/24/20.
//

import Foundation

var model = [ViewedNewsFeed]()

struct ViewedNewsFeed: Hashable {
    var image:String
    let title: String
    let id: Int
}

extension String {
   func replace(string:String, replacement:String) -> String {
       return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
   }

   func removeWhitespace() -> String {
       return self.replace(string: " ", replacement: "")
   }
 }

func getJSON() {
    guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=592d4e7b92964bda9a76c8838870535c") else {
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else {
            return
        }
        
        let decoder = JSONDecoder()
        guard let newsFeed = try? decoder.decode(NewsFeed.self, from: data) else { return }
        let children = newsFeed.results
        
        for child in children {
            
            let foodTitle = child.title
            let foodImage = child.image
            let foodId = child.id
            
            
            model.append(ViewedNewsFeed.init(image: foodImage, title: foodTitle, id: foodId))
            
        }
        print(model[0].id)

        let name = model[0].title.removeWhitespace()
        
        print(name)

        
    }.resume()


}

struct NewsFeed: Decodable {
    
    let results: [InnerData]
    
    struct InnerData: Decodable {
        let title: String
        let image: String
        let id: Int
    }
}
