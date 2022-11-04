//
//  Apis.swift
//  SplitBill
//
//  Created by Saurabhnegi on 27/10/22.
//Api EndPoint: https://api.spaceflightnewsapi.net/v3/articles

import Foundation
import SwiftUI
struct SpaceData : Codable, Identifiable{
    
    var id : Int
    var title : String
    var url : String
    var imageUrl : String
    var newSite : String
    var summary : String
    var publishedAt : String
}
@MainActor class SpaceAPI : ObservableObject{
    @Published var news : [SpaceData] = []
    func getdata() {
        guard let url  = URL(string: "https://api.spaceflightnewsapi.net/v3/articles?_limit = 10") else{
            return
        }
        URLSession.shared.dataTask(with: url){ data,response , error in
            guard let data = data else{
                let tempError  = error!.localizedDescription
                DispatchQueue.main.async{
                    self.news = [SpaceData(id: 0, title: "Error", url: "Error", imageUrl: "Error", newSite: "Error", summary: "Try Swiping Down to refresh as soon as you have intereset ", publishedAt: "Error")]
                }
                return
            }
            let spaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
            DispatchQueue.main.async {
                print("API response \(spaceData.count)")
                self.news =  spaceData
            }
            
        }.resume()
    }
}

