#include <cppcms/application.h>
#include <cppcms/applications_pool.h>
#include <cppcms/service.h>
#include <cppcms/http_response.h>
#include <iostream>

class my_hello_world : public cppcms::application {
public:
    my_hello_world(cppcms::service &srv) :
        cppcms::application(srv) 
    {
    }
    virtual void main(std::string url);
};

void my_hello_world::main(std::string /*url*/)
{
    response().out()<<
        "<html>\n"
   "<head>"
        "<title>CppCMS App Lab</title>"
        "<meta charset=\"utf-8\">"
        "<!-- Latest compiled and minified CSS --> "
        "<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css\">"
        "<!-- jQuery library --> "
        "<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js\"></script>"
        "<!-- Latest compiled JavaScript --> "
        "<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js\"></script>"
        "<link rel=\"stylesheet\" href=\"https://s3.amazonaws.com/ohrs-aws/css/site.css\">"
        "<style>"
            "body {"
                "color: rgb(15, 15, 15);"
                "background-color:rgb(250, 250, 250);"
            "}   "
            "h1 {"
                "font-family:Sans-serif;"
                "background-color:#ffffff;"
                "color:white;"
            "}   "
            "img { "
                "display: block;"
                "margin-left: auto;"
                "margin-right: auto;"
                "width:25%; "
            "}   "
            ".line-info{"
                "color: #696979;"
                "font-size:115%;"
            "}   "
        "</style>"
        "<body>\n"
         "<nav class=\"navbar navbar-inverse\">"
          "<div class=\"container-fluid\">"
            "<div class=\"navbar-header\">"
              "<a class=\"navbar-brand\" href=\"https://s3.amazonaws.com/ohrs-aws/index.html\">Home</a>"
            "</div>"
            "<ul class=\"nav navbar-nav\">"
              "<li><a href=\"http://aws-alb-lab-942269274.us-east-1.elb.amazonaws.com:4444\"> Dev </a></li>"
              "<li><a href=\"http://aws-alb-lab-942269274.us-east-1.elb.amazonaws.com:4444\"> Prod </a></li>"
            "</ul>"
            "<p class=\"navbar-text\" style=\"font-family:Sans-serif;color:white\"> CppCMS Lab v:0.00.006a</p>"
            "<p class=\"navbar-text\" style=\"font-family:Sans-serif;float:right\"> Horário UTC:  <span style=\"color:gray\">   </span></p>"
          "</div>"
        "</nav>"
        "  <h1>Hello World... Up and Running!!</h1>\n"
        "</body>\n"
        "</html>\n";
}

int main(int argc,char ** argv)
{
    try {
        cppcms::service srv(argc,argv);
        srv.applications_pool().mount(cppcms::applications_factory<my_hello_world>());
        srv.run();
    }
    catch(std::exception const &e) {
        std::cerr<<e.what()<<std::endl;
    }
}
// vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4
