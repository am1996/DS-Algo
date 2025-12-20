package main
import (
  "database/sql"
  "net/http"
  "log"
  "encoding/json"
  _ "modernc.org/sqlite"
)

type Article struct {
  Title string `json:"Title"`
  Desc string `json:"desc"`
  Content string `json:"content"`
}

var articles = []Article {
  Article{Title: "Test Title", Desc: "Test Description", Content: "Hello World"},
   Article{Title: "Test Title 2", Desc: "Test Description 2", Content: "Hello World 2"},
   Article{Title: "Test Title 3", Desc: "Test Description 3", Content: "Hello World 3"},
}
func homePage(w http.ResponseWriter, r *http.Request){
  log.Println("Endpoint Hit: homePage")
  json.NewEncoder(w).Encode(articles)
}
func main(){
  db, err := sql.Open("sqlite", "./db.sqlite")
  if err != nil {
    log.Fatal(err)
  }
  db.Exec("CREATE TABLE IF NOT EXISTS articles (id INTEGER PRIMARY KEY, title TEXT, desc TEXT, content TEXT)")
  defer db.Close()
  http.HandleFunc("/", homePage)
  log.Println("Server started on port 8080")
  log.Fatal(http.ListenAndServe(":8080", nil))
}