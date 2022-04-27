//
//  ApiClient.swift
//  Compositional Layout
//
//  Created by Oğuz Karatoruk on 26.04.2022.
//

import Foundation
import Alamofire

class ApiClient {

    func getUsers(completion: @escaping (_ users: [User]?, _ success: Bool) -> ()){
        AF.request(Endpoint.baseURL(.users)(), encoding: URLEncoding.default).responseData { response in
            switch response.result{
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([User].self, from: data)
                    completion(result, true)
                } catch let error {
                    completion(nil, false)
                    print(error)
                }
            case .failure(let error):
                completion(nil, false)
                print(error)
            }
        }
    }
    
    func getAlbum(userId: Int, completion: @escaping (_ album: [Album]?, _ success: Bool) -> ()){
        let parameters: Parameters = [ "userId": userId ]
        AF.request(Endpoint.baseURL(.album)(),parameters: parameters, encoding: URLEncoding.default).responseData { response in
            switch response.result{
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([Album].self, from: data)
                    completion(result, true)
                } catch let error {
                    completion(nil, false)
                    print(error)
                }
            case .failure(let error):
                completion(nil, false)
                print(error)
            }
        }
    }
    
    func getPhotos(albumId: Int, completion: @escaping (_ photos: [Photo]?, _ success: Bool) -> ()){
        let parameters: Parameters = [ "albumId": albumId ]
        AF.request(Endpoint.baseURL(.photos)(), parameters: parameters,encoding: URLEncoding.default).responseData { response in
            switch response.result{
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([Photo].self, from: data)
                    completion(result, true)
                } catch let error {
                    completion(nil, false)
                    print(error)
                }
            case .failure(let error):
                completion(nil, false)
                print(error)
            }
        }
    }
    
    
}

