import Foundation
import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    router.post(Poll.self, at: "polls", "create") { req, poll -> Future<Poll> in
        return poll.save(on: req)
    }
    
    router.get("polls", "list")  { req -> Future<[Poll]> in
        return Poll.query(on: req).all()
    }
    
    router.post("polls", "vote", UUID.parameter, Int.parameter) { req -> Future<Poll> in
        let id = try req.parameter(UUID.self)
        let vote = try req.parameter(Int.self)
        return try Poll.find(id, on: req).flatMap(to: Poll.self) { poll in
            guard var poll = poll else {
                throw Abort(.notFound)
            }
            if vote == 1 {
                poll.votes1 += 1
            } else {
                poll.votes2 += 1
                
            }
            return poll.save(on: req)
        }
    }
}
