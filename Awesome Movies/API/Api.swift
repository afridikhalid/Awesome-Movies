//
//  Api.swift
//  Awesome Movies
//
//  Created by Khalid Afridi on 2024-05-19.
//

import Foundation


/// This class is a wrapper for all things related to the HTTP API.
///
/// The API handles formatting the HTTP request, parsing the HTTP response
///
/// - NOTE:
///   The Api class is currently designed as a singleton instead of creating a new reference each time we make new requests
///   Later on in case
class Api {
    
    /// For any production application we get use different methods but for this simple app we will be using only `GET` or `Post`
    ///
    ///  - NOTE:
    ///     We can add more methods to this enum to support different Methods e.g
    ///
    ///     `HEAD`, `PATCH`, `DELETE` or `OPTIONS`
    enum Method: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
    }
    
    /*
     // in case the app supports login and tokan validation then we can use this enum
    enum SessionState {
        case signedIn // The session cookie looks valid
        case expiredToken // The session cookie has expired or there is no session cookie.
    }
    */
    
    
    static let shared = Api()
    
    // we changes initialization access level
    private init() { }
    
    /// Which BaseURL / Server to use - `Staging`, `Dev`, `Production` or maybe any other server
    /// We can create a new Enum which can return different URLs based on Scheme setup
    fileprivate let baseURL: String = "https://api.themoviedb.org/3"
    
    // FIXME: Please provide your bearar token
    // We can even use a .plist file to save all the necessary keys or we can try to Obfucate the bearar token or the Api keys so they are not readable for more security and keep the file in a safe place e.g passkey or somewhere similar
    fileprivate let beararToken: String = ""
    
    
    /// Prepares a request with given, path and executes that on the session.
    /// Query is optional. If supplied they are formatted in the way the server expects them.
    ///  - NOTE:
    ///
    ///  Post functionality is not implemented but we can pass in the body as a Generic Any and then prepare it for `POST...`
    func execute<T: Codable>(method: Method, path: String, query: [String: String]? = nil) async throws -> T {
        
        
        guard !beararToken.isEmpty else {
            fatalError("Bearar Token is empty please provide your bearer token")
        }
        
        guard var components = URLComponents(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        components.path += path
        
        // if there's any query then we add those queries to the components
        if let query = query {
            components.queryItems = query.compactMap({ (key, value) in URLQueryItem(name: key, value: value) })
        }
        
        // create a request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(beararToken)"
        ]
        
        request.timeoutInterval = 10
        
        let (data, res) = try await URLSession.shared.data(for: request)
        guard let response = res as? HTTPURLResponse else {
            throw NSError(domain: "Invalid response", code: 0)
        }
        
        
        // we assume any response between 200 and 299 is a success
        if (200...299).contains(response.statusCode) {
            // We can use the .run fuction to switch to main but any function which class this task will
            // We can use the MainActor.run to switch to main but since we mark the calling functions with @MainActor so I can show different implementation possibility
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            // check for different error codes e.g 401, 403, 404 and so on
            throw NSError(domain: "Response error", code: response.statusCode)
        }
        
        
    }
    
    
    
    
    
}
