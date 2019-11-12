import Foundation

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T>) -> Void)
}

extension APIClient {
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T>) -> Void) {

        let task = decodingTask(with: request) { (value: T?, error) in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(error))
                }

                guard let value = value else {
                    return completion(.failure(APIError.invalidData))
                }

                completion(.success(value))
            }
        }

        task.resume()
    }
}

extension APIClient {
    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            completion: @escaping (T?, Error?) -> Void) -> URLSessionDataTask {

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(nil, error)
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(nil, APIError.requestFailed)
            }

            guard httpResponse.statusCode == 200 else {
                return completion(nil, APIError.responseUnsuccessful)
            }

            guard let data = data else {
                return completion(nil, APIError.invalidData)
            }

            guard let genericModel = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(nil, APIError.jsonConversionFailure)
            }

            completion(genericModel, nil)
        }
        return task
    }
}
