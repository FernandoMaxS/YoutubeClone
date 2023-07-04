//
//  HomeProvider.swift
//  YoutubeClone
//
//  Created by Fernando Maximiliano on 03/07/23.
//

import Foundation

class HomeProvider{
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel {

        var queryParams: [String: String] = ["part":"snippet"]
        if !channelId.isEmpty {
            queryParams["channelId"] = channelId
        }
        if !searchString.isEmpty {
            queryParams["q"] = searchString
        }
        let requestModel = RequestModel(endpoint: .search, queryItems: queryParams, baseUrl: .youtube)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, VideoModel.self)
            return model
        }catch{ // error lo regresa el catch
            print(error)
            throw error
        }
        
        
    }
}
