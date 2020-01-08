import ballerina/http;
import ballerina/stringutils;
import ballerina/log;

service hello on new http:Listener(9090) {
    resource function sayHello(http:Caller caller, http:Request req) returns error? {

        string name = req.getQueryParamValue("name") ?: "<uknown>";
        if (isValidName(name)) {
            log:printInfo("valid name received: " + name);
            var response = caller->respond("Hello, " + <@untainted> name);
        } else {
            log:printInfo("invalid name: " + name);
            var resp = new http:Response();
            resp.statusCode = http:STATUS_BAD_REQUEST;
            var response = caller->respond(resp);
        }
    }
}

function isValidName(string name) returns boolean {
    return stringutils:matches(name, "[a-zA-Z]+");
}
