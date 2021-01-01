//
//  File.swift
//  SnackTrack-test
//
//  Created by Saurav Kumar on 10/24/20.
//

import Foundation
import SwiftSoup

var model = [FoodList]()

struct FoodList: Hashable {
    var image:String
    let title: String
    let url: String
}

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "-")
    }
    func removeApostrephes() -> String {
        return self.replace(string: "'", replacement: "")
    }
    func removeEAccent() -> String {
        return self.replace(string: "é", replacement: "e")
    }
    func removeAAccent() -> String {
        return self.replace(string: "á", replacement: "a").replace(string: "ñ", replacement: "n").replace(string: ":", replacement: "")
    }
    func removeUAccent() -> String {
        return self.replace(string: "ú", replacement: "u")
    }
    func removeOAccent() -> String {
        return self.replace(string: "ó", replacement: "o")
    }
    

}

func getJSON() {
    var jsonData = ""
    
    if let url = URL(string: "https://tasty.co/") {
        do {
            let contents = try String(contentsOf: url)
//            print(contents)
            do {
                let doc: Document = try SwiftSoup.parse(contents)
                var number = 1
                for item in try doc.select("script") {
//                    let json = try item.attr("json")
                    if number == 6 {
//                        print("JSON BELOW")
//                        print(item)
                        jsonData = "\(item)"
//                        print(jsonData)
                    }
                    number = number + 1
                }
                
            } catch Exception.Error(let type, let message) {
                print(message)
            } catch {
                print("error")
            }
        } catch {
             print("contents could not be loaded")
        }
    } else {
         print("the URL was bad!")
    }


    guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=592d4e7b92964bda9a76c8838870535c") else {
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let str = jsonData.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

        guard let data = data else {
            print("error")
            return
        }

        let decoder = JSONDecoder()
        let jsonDataDataType = str.data(using: .utf8)!
//        print("EPEPEEE")
//        print(str)

        print(jsonDataDataType)
        guard let newsFeed = try? decoder.decode(TastyJson.self, from: jsonDataDataType) else {
            print("error in decoding")
//            print(str)
            return
        }
        
        
        let children = newsFeed.props.pageProps.trendingFeed
        print("CHILDREN BELOW")
//        print(children)


        for child in children {

            
            let foodTitle = child.name
            let imageURL = child.thumbnail_url
            let urlToRecipe = "https://tasty.co/recipe/\(foodTitle.lowercased().removeWhitespace().removeApostrephes().removeEAccent().removeUAccent().removeAAccent().removeOAccent())"
            print(urlToRecipe)
            model.append(FoodList.init(image: imageURL, title: foodTitle, url: urlToRecipe))
        }
        print(model[0])
        
    }.resume()
    
    print("json is gotten")
}

struct NewsFeed: Decodable {
    
    let results: [InnerData]
    
    struct InnerData: Decodable {
        let title: String
        let image: String
        let id: Int
    }
}
struct TastyJson: Decodable {
    let props: Props
    
    struct Props: Decodable {
        let pageProps: PageProps
        
        struct PageProps: Decodable {
            let trendingFeed: [Trending]
                    struct Trending: Decodable {
                        let name: String
                        let thumbnail_url: String

                    }
        }
    }
}

