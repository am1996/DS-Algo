
#include "Crow/include/crow.h"
#include <jwt-cpp/jwt.h> // Include the jwt-cpp library

int main() {
  crow::SimpleApp app;

  CROW_ROUTE(app, "/")
  ([](const crow::request req) {
    auto page = crow::mustache::load("index.html");
    crow::mustache::context ctx({{"person", "Alpine"}}); //
    return page.render(ctx);
  });

  app.port(5000).multithreaded().run();
}
