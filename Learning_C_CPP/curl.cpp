
#include <curl/curl.h>
#include <gumbo.h>
#include <iostream>
#include <string>
#include <vector>

// Callback function to handle received data
size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* userp) {
    userp->append((char*)contents, size * nmemb);
    return size * nmemb;
}

// Extract text from HTML nodes
std::string cleanText(GumboNode* node) {
    if (node->type == GUMBO_NODE_TEXT) {
        return std::string(node->v.text.text);
    } else if (node->type == GUMBO_NODE_ELEMENT) {
        std::string contents;
        GumboVector* children = &node->v.element.children;
        for (unsigned int i = 0; i < children->length; ++i) {
            contents += cleanText((GumboNode*) children->data[i]);
        }
        return contents;
    } else {
        return "";
    }
}

int main() {
    CURL* curl = curl_easy_init();
    std::string readBuffer;

    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://example.com");
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);

        CURLcode res = curl_easy_perform(curl);
        
        if(res != CURLE_OK) {
            std::cerr << "curl_easy_perform() failed: " << curl_easy_strerror(res) << std::endl;
        } else {
            // Parse the HTML content
            GumboOutput* output = gumbo_parse(readBuffer.c_str());
            std::string text = cleanText(output->root);
            std::cout << "Extracted text: " << text << std::endl;
            
            gumbo_destroy_output(&kGumboDefaultOptions, output);
        }

        curl_easy_cleanup(curl);
    }

    return 0;
}
