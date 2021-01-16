//
//  APIClient.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation


class APIClient: NetworkSeviceInterceptorable {
    
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func send<T>(request: NetworkRequestConvertiable, decoder: DataDecoder, interceptor: NetworkIntercaptor, completion: @escaping ResultCompletion<T>) where T : Decodable {
        
        do {
            let request = try request.asURLRequest()
            
            interceptor.adapt(request, for: session) { [weak self] (result) in
                switch result {
                case .success(let value):
                    self?.send(request: value, decoder: decoder, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }catch let error {
            completion(.failure(error))
        }
    }
    
    func download(request: NetworkRequestConvertiable, interceptor: NetworkIntercaptor, completion: @escaping ResultCompletion<Data>) {
        do {
            let request = try request.asURLRequest()
            
            interceptor.adapt(request, for: session) {[weak self] (result) in
                switch result {
                case .success(let value):
                    self?.download(request: value, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }catch let error {
            completion(.failure(error))
        }
    }
    
    func send<T>(request: NetworkRequestConvertiable, decoder: DataDecoder, completion: @escaping ResultCompletion<T>) where T : Decodable {
        do {
            let request = try request.asURLRequest()
            let downloadTask = session.dataTask(with: request) { (data, response, error) in
                //TODO: implement later.
                
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                //TODO: check status codes.
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    //FIXME: return error
                    completion(.failure(NSError()))
                    return
                }
                
                guard let data = data, data.count >= 0 else {
                    completion(.failure(NSError()))
                    return
                }
                
                do {
                    let returnObj = try decoder.decode(T.self, from: data)
                    completion(.success(returnObj))
                }catch let error {
                    completion(.failure(error))
                }
                
            }
            downloadTask.resume()
            
        }catch let error {
            completion(.failure(error))
        }
    }
    
    func download(request: NetworkRequestConvertiable, completion: @escaping ResultCompletion<Data>) {
        do {
            let request = try request.asURLRequest()
            let downloadTask = session.downloadTask(with: request) { (tempDownloadURL, response, error) in
                
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                //TODO: check status codes.
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    //FIXME: return error
                    completion(.failure(NSError()))
                    return
                }
                
                guard let outputfileURL = tempDownloadURL else {
                    completion(.failure(NSError()))
                    return
                }
                
                do {
                    let returnObj = try Data(contentsOf: outputfileURL)
                    completion(.success(returnObj))
                }catch let error {
                    completion(.failure(error))
                }
            }
            downloadTask.resume()
            
        }catch let error {
            completion(.failure(error))
        }
    }
    
    
    
}
