//
//  NetworkManager.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation
import Moya

typealias NetworkMangerCompletion<T: Codable> = ((_ response: APIBaseResponse<T>?, _ error: String?) -> Void)

class NetworkManager<APIType: TargetType> {

    private var provider: MoyaProvider<APIType>?

    init(with type: NetworkManagerProviderType<APIType>? = .live) {
        self.provider = type?.getProvider()
    }

    func request<T: Codable>(target: APIType, completion: @escaping NetworkMangerCompletion<T>) {
        provider?.request(target) { result in
            switch result {
            case let .success(response):
                self.printResponse(response)
                let decodedData: (decodedType: APIBaseResponse<T>?, error: Error?) = decode(response.data)
                if let type = decodedData.decodedType {
                    if type.status {
                        completion(type, nil)
                    } else {
                        completion(type, type.message)
                    }
                } else {
                    completion(nil, decodedData.error?.localizedDescription)
                }
            case let .failure(error):
                completion(nil, error.localizedDescription)
            }
        }
    }

    func printResponse(_ response: Response) {
        debugPrint("=========================================================")
        print("\(response.request?.url?.absoluteString ?? "") response:")
        do { try print(response.mapJSON(failsOnEmptyData: true))
        } catch {
            print("exception")
        }
        debugPrint("=========================================================")
    }

    func cancelAllRequest() {
        DefaultAlamofireSession.shared.session.getAllTasks {sessionTasks in
            for task in sessionTasks {
                task.cancel()
            }
        }
    }
}
