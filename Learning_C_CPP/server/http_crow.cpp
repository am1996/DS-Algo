#include "crow_all.h"
#include <iostream>
#include <sqlite3.h>

// Database initialization
sqlite3 *db;

bool initDB() {
  if (sqlite3_open("sqlite.db", &db) != SQLITE_OK) {
    std::cerr << "Failed to open DB\n";
    return false;
  }

  const char *sql = "CREATE TABLE IF NOT EXISTS names (id INTEGER PRIMARY KEY "
                    "AUTOINCREMENT, name TEXT);";
  char *errMsg = nullptr;
  if (sqlite3_exec(db, sql, nullptr, nullptr, &errMsg) != SQLITE_OK) {
    std::cerr << "Failed to create table: " << errMsg << "\n";
    sqlite3_free(errMsg);
    return false;
  }
  return true;
}

bool insertName(const std::string &name) {
  sqlite3_stmt *stmt;
  const char *sql = "INSERT INTO names (name) VALUES (?);";

  if (sqlite3_prepare_v2(db, sql, -1, &stmt, nullptr) != SQLITE_OK)
    return false;
  sqlite3_bind_text(stmt, 1, name.c_str(), -1, SQLITE_TRANSIENT);

  bool success = (sqlite3_step(stmt) == SQLITE_DONE);
  sqlite3_finalize(stmt);
  return success;
}

std::string getNamesJson() {
  sqlite3_stmt *stmt;
  const char *sql = "SELECT name FROM names;";
  std::string json = "[";

  if (sqlite3_prepare_v2(db, sql, -1, &stmt, nullptr) == SQLITE_OK) {
    bool first = true;
    while (sqlite3_step(stmt) == SQLITE_ROW) {
      if (!first)
        json += ", ";
      first = false;
      const unsigned char *name = sqlite3_column_text(stmt, 0);
      json += "\"" + std::string(reinterpret_cast<const char *>(name)) + "\"";
    }
    sqlite3_finalize(stmt);
  }
  json += "]";
  return json;
}

int main() {
  if (!initDB())
    return 1;

  crow::SimpleApp app;

  // Route: Add name
  CROW_ROUTE(app, "/add").methods("POST"_method)([](const crow::request &req) {
    auto body = crow::json::load(req.body);
    if (!body || !body.has("name"))
      return crow::response(400, "Invalid JSON");

    std::string name = body["name"].s();
    if (insertName(name))
      return crow::response(200, "Name saved.");
    else
      return crow::response(500, "DB insert failed.");
  });

  // Route: List names
  CROW_ROUTE(app, "/list")
  ([] { return crow::response(getNamesJson()); });

  std::cout << "Server started at http://localhost:18080\n";
  app.port(18080).multithreaded().run();

  sqlite3_close(db);
  return 0;
}
