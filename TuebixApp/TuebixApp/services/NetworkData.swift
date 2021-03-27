//
//  NetworkData.swift
//  TuebixApp
//
//  Created by Alejandro Martinez Montero on 26/3/21.
//

import Foundation


protocol NetworkDataDelegate {
    func didReceiveData(fetchedData: Data)
    func didOccurrErrorInFetching(_ error: String)
}

/*
Retrieves data from a network. It uses a protocol to
give either an error or the Data retrieved
*/
class NetworkData {
    
    var delegate: NetworkDataDelegate?
    
    
    
    func fetchData(from url: String) {
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else {
                if let error = error {
                    DispatchQueue.main.async {
                        self.delegate?.didOccurrErrorInFetching(error.localizedDescription)
                    }
                }
                return
            }
            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.delegate?.didReceiveData(fetchedData: data)
                }
            }
            else {
                //self.delegate?.didOccurrErrorInFetching(error?.localizedDescription)
            }
        }
        task.resume()
    }
}
