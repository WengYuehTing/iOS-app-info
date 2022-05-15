#!/usr/bin/swift sh
import Foundation

let arguments = CommandLine.arguments
precondition(arguments.count > 1, "Please enter at least one app id")

let semaphore = DispatchSemaphore(value: 1)
print("The result(s) shown as follows: ")
for appID in arguments[1..<arguments.count] {
    let urlString = "https://itunes.apple.com/lookup?id=" + appID
    let url = URL(string: urlString)!
    
    semaphore.wait()
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        precondition(error == nil, error!.localizedDescription)
        guard let data = data,
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let results = json["results"] as? Array<[String: Any]>,
              let resultCount = json["resultCount"] as? Int else {
            fatalError("Parsing json failure!")
        }
        
        let bundleID = resultCount > 0 ? results[0]["bundleId"]! : "Not Found"
        print("\(appID) --> \(bundleID)")
        semaphore.signal()
    }
    
    task.resume()
}

semaphore.wait()
