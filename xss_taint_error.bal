import ballerina/http;

service hello on new http:Listener(9090) {
    resource function sayHello(
    http:Caller caller, http:Request req) {
        string name = req.getQueryParamValue("name") ?: "<unknown>";
        http:Response res = new http:Response();
        res.setContentType("html");
        res.setTextPayload("<html>" + <@untainted> name + "</html>");
        var response = caller->respond(res);
    }
}
