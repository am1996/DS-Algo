
#include "Crow/include/crow.h"

int main()
{
    crow::SimpleApp app;

    CROW_ROUTE(app, "/")([](){
        return "Hello world";
    });

    CROW_ROUTE(app, "/json")([]{
        crow::json::wvalue x;
        x["message"] = "Hello, World!";
        return x;
    });

    CROW_ROUTE(app, "/hello/<string>")([](const std::string& name){
        return "Hello " + name + "!";
    });

    app.port(5000).multithreaded().run();
}
