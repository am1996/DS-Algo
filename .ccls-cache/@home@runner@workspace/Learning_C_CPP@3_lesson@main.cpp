
#include "Crow/include/crow.h"
#include <jwt-cpp/jwt.h> // Include the jwt-cpp library

int main() {
  crow::SimpleApp app;
  CROW_ROUTE(app, "/login")
      .methods("POST"_method)([](const crow::request &req) {
        // In a real application, you'd verify username/password
        // and retrieve user data from a database.
        std::string username = "testuser";

        // Create and sign a JWT
        auto token = jwt::create()
                         .set_issuer("auth.example.com")
                         .set_type("JWT")
                         .set_payload_claim("user_id", jwt::claim(123))
                         .sign(jwt::algorithm::hs256(jwt_secret));

        return crow::response(200, token);
      });
  CROW_ROUTE(app, "/")
  ([](const crow::request req) {
    auto page = crow::mustache::load("index.html");
    crow::mustache::context ctx({{"person", "Alpine"}}); //
    return page.render(ctx);
  });

  app.port(5000).multithreaded().run();
}
