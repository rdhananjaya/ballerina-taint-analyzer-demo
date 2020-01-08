import ballerina/http;

// localhost:9090/hello/sayHello?name=dhananjaya
// localhost:9090/hello/sayHello?name=<script>alert("hi")%3B<%2Fscript>

service hello on new http:Listener(9090) {
    resource function sayHello(
    http:Caller caller, http:Request req) {
        string name = req.getQueryParamValue("name") ?: "<unknown>";
        http:Response res = new http:Response();
        res.setPayload("<html><header>Injection sample</header>" + name + "</html>");
        res.setContentType("text/html");
        var response = caller->respond(res);
    }
}
