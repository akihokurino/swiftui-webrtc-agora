// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GraphQL namespace
public enum GraphQL {
  public final class AgoraTokenQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query AgoraToken($channelName: String!) {
        agoraToken(channelName: $channelName) {
          __typename
          token
        }
      }
      """

    public let operationName: String = "AgoraToken"

    public var channelName: String

    public init(channelName: String) {
      self.channelName = channelName
    }

    public var variables: GraphQLMap? {
      return ["channelName": channelName]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("agoraToken", arguments: ["channelName": GraphQLVariable("channelName")], type: .nonNull(.object(AgoraToken.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(agoraToken: AgoraToken) {
        self.init(unsafeResultMap: ["__typename": "Query", "agoraToken": agoraToken.resultMap])
      }

      public var agoraToken: AgoraToken {
        get {
          return AgoraToken(unsafeResultMap: resultMap["agoraToken"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "agoraToken")
        }
      }

      public struct AgoraToken: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["AgoraToken"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("token", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(token: String) {
          self.init(unsafeResultMap: ["__typename": "AgoraToken", "token": token])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var token: String {
          get {
            return resultMap["token"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "token")
          }
        }
      }
    }
  }
}
