////
////  FoursquareAPI.swift
////  TestApp
////
////  Created by Maxim Potapov on 23.09.2021.
////
//
//import Foundation
//import Combine
//
//public struct FoursquareAPI {
//
//    static let baseUrl = "https://dev.web.lets-roll.app/api"
//
//    public enum URLError: Error {
//        case unableToCreateURL
//    }
//    
//    public enum AuthorizationError:Error {
//        case unauthorized
//    }
//
//    public enum APIError: Error {
//        case unknownError
//        case failure(msg: String)
//        case missingRecord
//        case emptyResponse
//        case invalidRequest
//    }
//}
//
//protocol LetsRollCloudAPIRESTProtocol {}
//
//extension LetsRollCloudAPIRESTProtocol {
//
//    func getWithDecode<T: Decodable>(endpoint: String, params: [String: String]? = nil) -> AnyPublisher<T, Error> {
//        let request = createRequest(method: .get, path: endpoint, params: params)
//        request.allHTTPHeaderFields = commonHeaders()
//        return signRequest(request)
//            .flatMap { URLSession.shared.dataTaskPublisher(for: $0 as URLRequest) }
//            .letsRoll_unwrapErrorResponseJSON()
//            .map { (data, response) in return data }
//            .letsRoll_decodeFromJson(T.self)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//
//    func put(endpoint:String, body: Data?, params: [String: String]? = nil) -> AnyPublisher<Data, Error> {
//        let request = createRequest(method: .put, path: endpoint, params: params)
//        request.httpBody = body
//        request.allHTTPHeaderFields = commonHeaders()
//        if let uBody = body {
//            appLog.debug("PostBody: \(String(data: uBody, encoding: .utf8) ?? "")")
//        }
//        return signRequest(request)
//            .flatMap { URLSession.shared.dataTaskPublisher(for: $0 as URLRequest) }
//            .letsRoll_unwrapErrorResponseJSON()
//            .map { (data, response) in return data }
//            .receive(on: DispatchQueue.main)
//            .catch({ (error) -> AnyPublisher<Data, Error> in
//                if let apiErr = error as? LetsRollAPI.APIError {
//                    switch apiErr {
//                    case .missingRecord:
//                        return post(endpoint: endpoint, body: body, params: params)
//                    default:
//                        break
//                    }
//                }
//                return Fail(error: error).eraseToAnyPublisher()
//            })
//            .eraseToAnyPublisher()
//    }
//
//    func post(endpoint:String, body: Data?, params: [String: String]? = nil) -> AnyPublisher<Data, Error> {
//        let request = createRequest(method: .post, path: endpoint, params: params)
//        request.httpBody = body
//        request.allHTTPHeaderFields = commonHeaders()
//        if let uBody = body {
//            appLog.debug("PostBody: \(String(data: uBody, encoding: .utf8) ?? "")")
//        }
//        return signRequest(request)
//            .flatMap { URLSession.shared.dataTaskPublisher(for: $0 as URLRequest) }
//            .letsRoll_unwrapErrorResponseJSON()
//            .map { (data, response) in return data }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//
//    func postWithDecode<T: Decodable>(endpoint: String, body: Data, params: [String: String]? = nil) -> AnyPublisher<T, Error> {
//        let request = createRequest(method: .post, path: endpoint, params: params)
//        request.httpBody = body
//        request.allHTTPHeaderFields = commonHeaders()
//        appLog.debug("PostBody: \(String(data: body, encoding: .utf8) ?? "")")
//        return signRequest(request)
//            .flatMap { URLSession.shared.dataTaskPublisher(for: $0 as URLRequest) }
//            .letsRoll_unwrapErrorResponseJSON()
//            .map { (data, response) in return data }
//            .letsRoll_decodeFromJson(T.self)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//
//    func patch(endpoint:String, body: Data?, params: [String: String]? = nil) -> AnyPublisher<Data, Error> {
//        let request = createRequest(method: .patch, path: endpoint, params: params)
//        request.httpBody = body
//        request.allHTTPHeaderFields = commonHeaders()
//        if let uBody = body {
//            appLog.debug("PostBody: \(String(data: uBody, encoding: .utf8) ?? "")")
//        }
//        return signRequest(request)
//            .flatMap { URLSession.shared.dataTaskPublisher(for: $0 as URLRequest) }
//            .letsRoll_unwrapErrorResponseJSON()
//            .map { (data, response) in return data }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//
//    func patchWithDecode<T: Decodable>(endpoint: String, body: Data, params: [String: String]? = nil) -> AnyPublisher<T, Error> {
//        let request = createRequest(method: .patch, path: endpoint, params: params)
//        request.httpBody = body
//        request.allHTTPHeaderFields = commonHeaders()
//        appLog.debug("PostBody: \(String(data: body, encoding: .utf8) ?? "")")
//        return signRequest(request)
//            .flatMap { URLSession.shared.dataTaskPublisher(for: $0 as URLRequest) }
//            .letsRoll_unwrapErrorResponseJSON()
//            .map { (data, response) in return data }
//            .letsRoll_decodeFromJson(T.self)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//
//    func delete(endpoint:String, params: [String: String]? = nil) -> AnyPublisher<Data, Error> {
//        let request = createRequest(method: .delete, path: endpoint, params: params)
//        request.allHTTPHeaderFields = commonHeaders()
//        return signRequest(request)
//            .flatMap { URLSession.shared.dataTaskPublisher(for: $0 as URLRequest) }
//            .letsRoll_unwrapErrorResponseJSON()
//            .map { (data, response) in return data }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//
//    func createRequest(method: URLRequest.HTTPMethod, path: String, params: [String: String]? = nil) -> NSMutableURLRequest {
//        let awsURL = URL(string: LetsRollAPI.baseUrl)
//        var comps = URLComponents()
//        comps.scheme = awsURL?.scheme
//        comps.host = awsURL?.host
//        comps.path = "\(awsURL?.path ?? "")\(path)"
//        if let parameters = params {
//            var queryItems = [URLQueryItem]()
//            for key in parameters.keys {
//                queryItems.append(URLQueryItem(name: key, value: parameters[key]))
//            }
//            comps.queryItems = queryItems
//        }
//        let urlRequest = NSMutableURLRequest(url: comps.url!)
//        urlRequest.httpMethod = method.rawValue
//        appLog.debug("\(method): \(comps.url!.absoluteURL)")
//        return urlRequest
//    }
//
//    func signRequest(_ request: NSMutableURLRequest) -> AnyPublisher<URLRequest, Never> {
//        if let tokens = AppPreferencesManager.shared.getTokens(), let jwtToken = tokens.accessToken.toJWTToken() {
//            let now = Date().timeIntervalSince1970
//            let tokenExpiration = jwtToken.expirationDate.timeIntervalSince1970
//            if now < tokenExpiration {
//                appLog.debug("Access token \(tokens.accessToken.toJWTToken()?.token) is still valid. Will expire on \(tokenExpiration)")
//                request.setValue("\(jwtToken.token)", forHTTPHeaderField: "Authorization")
//            } else {
//                appLog.debug("Need to refresh the access token")
//                if let refreshToken = tokens.refreshToken.toJWTToken() {
//                    if now < refreshToken.expirationDate.timeIntervalSince1970 {
//                        return refreshTokens(tokens.refreshToken, originalRequest: request)
//                    } else {
//                        appLog.warning("Refresh token expired. Should log out.")
//                        AppPreferencesManager.shared.signOut()
//                    }
//                }
//            }
//        }
//
//        return Just(request as URLRequest).eraseToAnyPublisher()
//    }
//
//    private func refreshTokens(_ refreshToken: String, originalRequest: NSMutableURLRequest) -> AnyPublisher<URLRequest, Never> {
//        appLog.debug("Refresh token is still valid")
//        let refreshTokenRequest = createRequest(method: .post, path: "/auth/signin/email")
//        let params: Dictionary<String, String> = ["refreshToken" : refreshToken]
//        let body = try? JSONSerialization.data(withJSONObject: params, options: .sortedKeys)
//        refreshTokenRequest.httpBody = body
//        refreshTokenRequest.allHTTPHeaderFields = commonHeaders()
//
//        return URLSession.shared.dataTaskPublisher(for: refreshTokenRequest as URLRequest)
//            .replaceError(with: (data: Data(), response: URLResponse()))
//            .map { (data, response) in
//                return data
//            }
//            .letsRoll_decodeFromJson(AccessResponse.self)
//            .map { response in
//                AppPreferencesManager.shared.saveTokens(accessToken: response.access, refreshToken: response.refresh)
//                originalRequest.setValue("\(response.access)", forHTTPHeaderField: "Authorization")
//                return originalRequest as URLRequest
//            }
//            .replaceError(with: originalRequest as URLRequest)
//            .eraseToAnyPublisher()
//    }
//
//    func commonHeaders() -> [String: String]? {
//        return ["Content-Type": "application/json", "Accept": "application/json"]
//    }
//}
//
