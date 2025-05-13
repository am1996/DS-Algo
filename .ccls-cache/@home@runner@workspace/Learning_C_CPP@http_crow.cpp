
#include "crow_all.h"

int main() {
    crow::SimpleApp app;

    CROW_ROUTE(app, "/")([]() {
        return "Hello World!";
    });

    CROW_ROUTE(app, "/json")([]() {
        crow::json::wvalue x;
        x["message"] = "Hello, World!";
        x["status"] = "success";
        return x;
    });

    app.bindaddr("0.0.0.0").port(5000).run();
    return 0;
}
