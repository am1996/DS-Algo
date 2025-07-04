
#include "Crow/include/crow.h"

int main() {
  crow::SimpleApp app;

  CROW_ROUTE(app, "/hehe")
  ([]() {
    auto page = crow::mustache::load("index.html");
    crow::mustache::context ctx({{"person", "Alpine"}}); //
    return page.render(ctx);
  });

  app.port(5000).multithreaded().run();
}
