//
//  APIClient.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/16/21.
//

import Foundation

enum APIClientError: Error {
    case noDataFound
    case statusCode(Int)
    case URLError(error: URLError)
    case decode(error: DecodingError)
    case otherError(Error)
}

class APIClient: NetworkServiceInterceptorable {
    
    let session: URLSession
    let operationQueue: DispatchQueue
    
    init(session: URLSession, operationQueue: DispatchQueue = .main) {
        self.session = session
        self.operationQueue = operationQueue
    }
    
    func send<T>(request: NetworkRequestConvertiable, decoder: DataDecoder, interceptor: NetworkIntercaptor, completion: @escaping ResultCompletion<T>) -> NetworkTask? where T : Decodable  {
        
        do {
            let request = try request.asURLRequest()
            let result = interceptor.adapt(request, for: session)
            
            switch result {
            case .success(let value):
                return self.send(request: value, decoder: decoder, completion: completion)
            case .failure(let error):
                completion(.failure(APIClientError.otherError(error)))
                return nil
            }
            
        }catch let error {
            completion(.failure(APIClientError.otherError(error)))
            return nil
        }
    }
    
    func download(request: NetworkRequestConvertiable, interceptor: NetworkIntercaptor, completion: @escaping ResultCompletion<Data>) -> NetworkTask? {
        do {
            let request = try request.asURLRequest()
            let result = interceptor.adapt(request, for: session)
            
            switch result {
            case .success(let value):
                return self.download(request: value, completion: completion)
            case .failure(let error):
                completion(.failure(APIClientError.otherError(error)))
                return nil
            }
            
        }catch let error {
            completion(.failure(APIClientError.otherError(error)))
            return nil
        }
    }
    
    func send<T>(request: NetworkRequestConvertiable, decoder: DataDecoder, completion: @escaping ResultCompletion<T>) -> NetworkTask? where T : Decodable {
        do {
            let request = try request.asURLRequest()
            let queue = self.operationQueue
            let task = session.dataTask(with: request) { (data, response, error) in
                
                guard error == nil else {
                    queue.performSafe {
                        if let error = error as? URLError {
                            completion(.failure(APIClientError.URLError(error: error)))
                            return
                        }
                        
                        completion(.failure(APIClientError.otherError(error!)))
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse, !(200..<301).contains(response.statusCode) {
                    queue.performSafe {
                        completion(.failure(APIClientError.statusCode(response.statusCode)))
                    }
                    return
                }
                
                guard let data = data, data.count >= 0 else {
                    queue.performSafe {
                        completion(.failure(APIClientError.noDataFound))
                    }
                    return
                }
                
                do {
                    let returnObj = try decoder.decode(T.self, from: data)
                    queue.performSafe {
                        completion(.success(returnObj))
                    }
                }catch let error {
                    queue.performSafe {
                        
                        if let error = error as? DecodingError {
                            completion(.failure(APIClientError.decode(error: error)))
                            return 
                        }
                        
                        completion(.failure(APIClientError.otherError(error)))
                    }
                    
                }
                
            }
            
            task.resume()
            return task
        }catch let error {
            operationQueue.performSafe {
                completion(.failure(APIClientError.otherError(error)))
            }
            return nil
        }
    }
    
    func download(request: NetworkRequestConvertiable, completion: @escaping ResultCompletion<Data>) -> NetworkTask? {
        do {
            let request = try request.asURLRequest()
            let queue = self.operationQueue
            
            let downloadTask = session.downloadTask(with: request) { (tempDownloadURL, response, error) in
                
                guard error == nil else {
                    queue.performSafe {
                        if let error = error as? URLError {
                            completion(.failure(APIClientError.URLError(error: error)))
                        }
                        completion(.failure(APIClientError.otherError(error!)))
                    }
                    return
                }
                
                //TODO: check status codes.
                if let response = response as? HTTPURLResponse, !(200..<301).contains(response.statusCode) {
                    queue.performSafe {
                        completion(.failure(APIClientError.statusCode(response.statusCode)))
                    }
                    return
                }
                
                guard let outputfileURL = tempDownloadURL else {
                    queue.performSafe {
                        completion(.failure(APIClientError.noDataFound))
                    }
                    return
                }
                
                do {
                    
                    let returnObj = try Data(contentsOf: outputfileURL)
                    queue.performSafe {
                        completion(.success(returnObj))
                    }
                }catch let error {
                    queue.performSafe {
                        completion(.failure(APIClientError.otherError(error)))
                    }
                }
            }
            
            downloadTask.resume()
            return downloadTask
        }catch let error {
            operationQueue.performSafe {
                completion(.failure(APIClientError.otherError(error)))
            }
            return nil
        }
    }
    
    
}
