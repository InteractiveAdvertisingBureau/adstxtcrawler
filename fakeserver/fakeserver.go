package main


import (
    "fmt"
    "log"
    "net/http"
    "io/ioutil"
)

func formHandler(w http.ResponseWriter, r *http.Request) {
    if err := r.ParseForm(); err != nil {
        fmt.Fprintf(w, "ParseForm() err: %v", err)
        return
    }
    fmt.Fprintf(w, "POST request successful")
    name := r.FormValue("name")
    address := r.FormValue("address")
    fmt.Fprintf(w, "Name = %s\n", name)
    fmt.Fprintf(w, "Address = %s\n", address)
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
    log.Println("Hostname", r.Host ,"Path:", r.URL.Path, "Query:", r.URL.RawQuery)

    if r.Method != "GET" {
        http.Error(w, "Method is not supported.", http.StatusNotFound)
        return
    }

     if r.URL.Path !=  "/hello" {
        http.Error(w, "404 not found.", http.StatusNotFound)
        return
    }
        fmt.Fprintf(w, "Hello!")
        return
}

/* put these in your /etc/hosts

127.0.0.1	content_blue.com
127.0.0.1	content_yellow.com
127.0.0.1	mvpd_red.com
127.0.0.1	mvpd_fuchia.com
127.0.0.1	mvpd_orange.com

*/

func adsTxtHandler(w http.ResponseWriter, r *http.Request) {
    log.Println("Hostname", r.Host ,"Path:", r.URL.Path, "Query:", r.URL.RawQuery)

    if r.Method != "GET" {
        http.Error(w, "Method is not supported.", http.StatusNotFound)
        return
    }

    if r.URL.Path !=  "/ads.txt" {
        http.Error(w, "404 not found.", http.StatusNotFound)
        return
    }

    var adstxtfile = ""

    if(r.Host == "mvpd_red.com") {
        adstxtfile = "mvpd_red_com_ads.txt"
    } else if (r.Host == "mvpd_fuchsia.com") {
        adstxtfile = "mvpd_fuchsia_com_ads.txt"
    } else if (r.Host == "mvpd_orange.com") {
        adstxtfile = "mvpd_orange_com_ads.txt"
    } else if (r.Host == "content_blue.com") {
        adstxtfile = "content_blue_com_ads.txt"
    } else if (r.Host == "content_yellow.com") {
        adstxtfile = "content_yellow_com_ads.txt"
    } else {
        fmt.Fprintf(w, "#Empty Ads.txt %s", r.Host)
    }

    if(len(adstxtfile) > 0) {
        content, err := ioutil.ReadFile(adstxtfile)
        if err != nil {
            http.Error(w, "404 not found.", http.StatusNotFound)
            return
        } else {
            var content_str =  string(content)
            log.Println("serve file:", adstxtfile, "len", len(content_str))
            fmt.Fprintf(w, content_str)
            fmt.Fprintf(w, "#EOF")
        }
    }
}

func main() {
    fileServer := http.FileServer(http.Dir("./static"))
    http.Handle("/", fileServer)
    http.HandleFunc("/form", formHandler)
    http.HandleFunc("/hello", helloHandler)
    http.HandleFunc("/ads.txt", adsTxtHandler)


    fmt.Printf("Starting server at port 80\n")
    if err := http.ListenAndServe(":80", nil); err != nil {
        log.Fatal(err)
    }
}

