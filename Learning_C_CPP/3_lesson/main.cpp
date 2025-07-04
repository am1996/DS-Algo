
#include "Crow/include/crow.h"

int main() {
  crow::SimpleApp app;

  CROW_ROUTE(app, "/hehe")
  ([]() {
    auto page = crow::mustache::load_text("./templates/index.html");
    return page;
  });

  app.port(5000).multithreaded().run();
}
