//
//  DBManager+MachineBuild.swift
//  AmadaMachines
//
//  Created by IT Support on 11/12/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import Foundation

typealias machineBuildModelReturned = (MachineBuildModel?, Error?) -> Void
typealias machineBuildModelsReturned = ([MachineBuildModel]?, Error?) -> Void

extension DBManager {
    /*
    func get(model: MachineBuildModel, _ completionHandler: machineBuildModelsReturned?) {
        guard let apiURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
            let url = URL(string: "\(apiURL)/api/GetMachineBuilds") else {
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler?(nil,error)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler?(nil,nil)
                }
                return
            }

            do {
                let models = try JSONDecoder().decode([MachineBuildModel].self, from: data)
                DispatchQueue.main.async {
                    completionHandler?(models, nil)
                }
            } catch let err {
                DispatchQueue.main.async {
                    completionHandler?(nil, err)
                }
            }
        }
        task.resume()
    }*/

    func create(models: [MachineBuildModel], _ completionHandler: machineBuildModelsReturned?) {

        do {
            let data = try JSONEncoder().encode(models)
            print(String(data: data, encoding: .utf8))
            guard let apiURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
                let url = URL(string: "\(apiURL)/api/CreateMachineBuilds") else {
                    completionHandler?(nil, nil)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completionHandler?(nil, error)
                    return
                }
                guard let data = data else {
                    completionHandler?(nil,error)
                    return
                }
                let dataStr: String = String(data: data, encoding: .utf8) ?? "none"
                print("Create machineBuild: \(dataStr)")
                do {
                    let model = try JSONDecoder().decode([MachineBuildModel].self, from: data)
                    completionHandler?(model, nil)
                } catch let err {
                    completionHandler?(nil, err)
                }
            }
            task.resume()

        } catch let error {
            completionHandler?(nil, error)
        }
    }

    func create(model: MachineBuildModel, _ completionHandler: machineBuildModelReturned?) {
        do {
            let obj = try JSONEncoder().encode(model)
            guard let json = String(data: obj, encoding: .utf8),
                let apiURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
                let url = URL(string: "\(apiURL)/api/CreateMachineBuild") else {
                    completionHandler?(nil, nil)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json.data(using: .utf8)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completionHandler?(nil, error)
                    return
                }
                guard let data = data else {
                    completionHandler?(nil,error)
                    return
                }
                let dataStr: String = String(data: data, encoding: .utf8) ?? "none"
                do {
                    let model = try JSONDecoder().decode(MachineBuildModel.self, from: data)
                    completionHandler?(model, nil)
                } catch let err {
                    completionHandler?(nil, err)
                }
            }
            task.resume()

        } catch let error {
            completionHandler?(nil, error)
        }
    }
    /*
    func update(model: MachineBuildModel, _ completionHandler: machineBuildModelReturned?) {
        do {
            let obj = try JSONEncoder().encode(model)
            guard let json = String(data: obj, encoding: .utf8),
                let apiURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
                let url = URL(string: "\(apiURL)/api/UpdateBuildModel") else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json.data(using: .utf8)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completionHandler?(nil, error)
                    return
                }
                guard let data = data else {
                    completionHandler?(nil, error)
                    return
                }
                do {
                    let model = try JSONDecoder().decode(MachineBuildModel.self, from: data)
                    completionHandler?(model, nil)
                } catch let err {
                    completionHandler?(nil, err)
                }
            }
            task.resume()

        } catch let error {
            completionHandler?(nil, error)
        }
    }*/
}
