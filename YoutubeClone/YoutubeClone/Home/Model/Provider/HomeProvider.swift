//
//  HomeProvider.swift
//  YoutubeClone
//
//  Created by Fernando Maximiliano on 03/07/23.
//

import Foundation

protocol HomeProviderProtocol{
    func getVideos(searchString: String, channelId: String) async throws -> VideoModel
    func getChannel( channelId: String) async throws -> ChannelModel
    func getPlaylist( channelId: String) async throws -> PlaylistModel
    func getPlaylistItems( playlistId: String) async throws -> PlaylistItemsModel
}

class HomeProvider: HomeProviderProtocol{
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
    func getChannel( channelId: String) async throws -> ChannelModel {
        
        let queryParams: [String: String] = ["part":"snippet,statistics,brandingSettings",
                                             "id":channelId]
        let requestModel = RequestModel(endpoint: .channels, queryItems: queryParams, baseUrl: .youtube)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, ChannelModel.self)
            return model
        }catch{ // error lo regresa el catch
            print(error)
            throw error
        }
        
        
    }
    
    func getPlaylist( channelId: String) async throws -> PlaylistModel {
        
        let queryParams: [String: String] = ["part":"snippet,contentDetails",
                                             "channelId":channelId]
        let requestModel = RequestModel(endpoint: .playlist, queryItems: queryParams, baseUrl: .youtube)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, PlaylistModel.self)
            return model
        }catch{ // error lo regresa el catch
            print(error)
            throw error
        }
        
        
    }
    
    
    func getPlaylistItems( playlistId: String) async throws -> PlaylistItemsModel {
        
        let queryParams: [String: String] = ["part":"snippet,id,contentDetails",
                                             "playlistId":playlistId]
        let requestModel = RequestModel(endpoint: .playlistItems, queryItems: queryParams, baseUrl: .youtube)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, PlaylistItemsModel.self)
            return model
        }catch{ // error lo regresa el catch
            print(error)
            throw error
        }
        
        
    }
}
