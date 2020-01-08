import ballerina/http;
import ballerina/stringutils;

// localhost:9090/hello/sayHello?name=<script>alert("hi")%3B<%2Fscript>

service hello on new http:Listener(9090) {
    resource function sayHello(
    http:Caller caller, http:Request req) {
        string name = req.getQueryParamValue("name") ?: "<unknown>";
        if (isValidName(name)) {
            http:Response res = new http:Response();
            res.setPayload("<html><header>Injection sample</header>" + <@untainted>name + "</html>");
            res.setContentType("text/html");
            var response = caller->respond(res);
        } else {
            var resp = new http:Response();
            resp.statusCode = http:STATUS_BAD_REQUEST;
            var response = caller->respond(resp);
        }
    }
}

function isValidName(string name) returns boolean {
    return stringutils:matches(name, "[a-zA-Z]+");
}
