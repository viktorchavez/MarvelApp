//
//  CharactersProvider.swift
//  Data
//
//  Created by Viktor on 09/11/21.
//

import Domain
import Moya

public final class CharactersProvider: CharactersProviderContract {
    typealias MoyaCharactersService = MoyaProvider<CharactersService>
    
    private let provider: MoyaCharactersService
    
    init(_ provider: MoyaCharactersService) {
        self.provider = provider
    }
    
    public convenience init() {
        self.init(MoyaCharactersService())
    }
    
    public func characters(namePrefix: String?, offset: Int?, completion: @escaping CharactersListCompletion) {
        provider.request(.charactersList(namePrefix: namePrefix, offset: offset)) { result in
            do {
                let response = try result.get()
                let characters = try response.map(ResponseEntity.self).data.toDomain()
                completion(.success(characters))
            } catch let MoyaError.objectMapping(objectMappingError, response) {
                do {
                    let errorEntity = try response.map(ErrorEntity.self)
                    completion(.failure(.api(code: errorEntity.code, message: errorEntity.message)))
                } catch {
                    completion(.failure(.related(objectMappingError)))
                }
            } catch {
                completion(.failure(.related(error)))
            }
        }
    }
    
    public func character(id: Int, completion: @escaping CharacterCompletion) {
        provider.request(.character(id: id)) { result in
            do {
                let response = try result.get()
                let characters = try response.map(ResponseEntity.self).data.toDomain()
                if let character = characters.first {
                    completion(.success(character))
                } else {
                    completion(.failure(.characterNotFound))
                }
            } catch let MoyaError.objectMapping(objectMappingError, response) {
                do {
                    let errorEntity = try response.map(ErrorEntity.self)
                    completion(.failure(.api(code: errorEntity.code, message: errorEntity.message)))
                } catch {
                    completion(.failure(.related(objectMappingError)))
                }
            } catch {
                completion(.failure(.related(error)))
            }
        }
    }
}
