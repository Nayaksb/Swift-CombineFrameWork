import UIKit
import Combine

let urlString = "https://api.slingacademy.com/v1/sample-data/photos?offset=5&limit=20"

//Photo API Response Model
struct photo : Decodable {
    let id: Int
    let title: String
    let description: String
    let url: String
    let user: Int
//    enum CodingKeys: String, CodingKey {
//        case success = "success"
//        case id, title, description, url, user
//      }
}
struct PhotoAPIResponse: Decodable{
    let success: Bool
    let message: String
    let photos: [photo]
}

extension URLSession {
    func fetchData(at url: URL, completion: @escaping (Result<[PhotoAPIResponse], Error>) -> Void){
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let photos = try JSONDecoder().decode([PhotoAPIResponse].self, from: data)
          completion(.success(photos))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
let url = URL(string: urlString)!
URLSession.shared.fetchData(at: url) { result in
    switch result{
    case .success(let photos):
        //Woo we got photos
        print(photos)
    
    
    case .failure(let error):
    //Oooo, an error occured
    print(error)
    }
}
