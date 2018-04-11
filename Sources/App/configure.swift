import Vapor
import Fluent
import FluentSQLite

/// Called before your application initializes.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#configureswift)
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register directory Config
    let directoryConfig = DirectoryConfig.detect()
    services.register(directoryConfig)
    
    // Register DB
    try services.register(FluentSQLiteProvider())
    var databaseConfig = DatabaseConfig()
    let db = try SQLiteDatabase(storage: .file(path: "\(directoryConfig.workDir)polls.db"))
    databaseConfig.add(database: db, as: .sqlite)
    services.register(databaseConfig)
    
    // Migration config
    var migrationConfig = MigrationConfig()
    migrationConfig.add(model: Poll.self, database: .sqlite)
    services.register(migrationConfig)
}
