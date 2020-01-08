import ballerina/io;
import ballerina/http;

// public function main(string... args) {
//     io:println(args[0]);
//     secFuncIndirect(args[0]);
// }

function secFunc(@untainted string s) {
    // pass
}

function secFuncIndirect(string p) {
    secFunc(<@untainted> p);
}

service serviceName on new http:Listener(8080) {
    resource function newResource(http:Caller caller, http:Request request) {
        string name = request.getQueryParamValue("name") ?: "no-name";
        io:println(name);
        var resp = caller->ok();
    }
}