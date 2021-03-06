//
//  MenuController.swift
//  restApp
//
//  Created by user131292 on 3/7/18.
//  Copyright © 2018 kcooper5. All rights reserved.
//

import Foundation



class MenuController {
    let baseURL = URL(string: "http://localhost:8090/")!
    static let shared = MenuController()
    
    
    func fetchCategories(completion: @escaping ([String]?) -> Void){
        let categoryURL = baseURL.appendingPathComponent("categories")
        _ = URLSession.shared.dataTask(with: categoryURL) {
            (data, response, error) in
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
                let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
                } else {
                completion(nil)
            }
        }
    }
    
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        let data: [String: Any] = ["menuIds": menuIds]
        let jsonData = try? JSONSerialization.data(withJSONObject:data, options: []); request.httpBody = jsonData
        _ = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let prepTime = jsonDictionary?["preparation_time"] as? Int {
                    completion(prepTime)
            } else {
                completion(nil)
            }
        }
    }
            
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL,
            resolvingAgainstBaseURL: true)!
            components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        _ = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            _ = [MenuItem]()
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let menuArray = jsonDictionary?["items"] as?
                    [[String: Any]] {
                    let menuItems = menuArray.flatMap { MenuItem(json: $0) }
                    completion(menuItems)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) ->
        Void) {
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
