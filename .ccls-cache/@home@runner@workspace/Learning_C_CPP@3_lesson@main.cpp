
#include "Crow/include/crow.h"
#include <sqlite3.h>

int main() {
  crow::SimpleApp app;
  CROW_ROUTE(app, "/register")
  ([](const crow::request req) {
    if (req.method != crow::HTTPMethod::POST)
      return crow::response(400, "Method not allowed");
    auto x = crow::json::load(req.body);
    if (!x)
      return crow::response(400);
    std::string username = x["username"].s();
    std::string password = x["password"].s();
    sqlite3 *db;
    sqlite3_open("database.db", &db);
    std::string sql = "INSERT INTO users (username, password) VALUES ('" +
                      username + "', '" + password + "');";
    sqlite3_exec(db, sql.c_str(), NULL, NULL, NULL);
    sqlite3_close(db);
    return crow::response(200, "User Created Successfully");
  });
  CROW_ROUTE(app, "/")
  ([](const crow::request req) {
    auto page = crow::mustache::load("index.html");
    crow::mustache::context ctx({{"person", "Alpine"}}); //
    return page.render(ctx);
  });

  app.port(5000).multithreaded().run();
}
