import ballerina/http;
import ballerina/lang.'int;
import ballerinax/java.jdbc;

jdbc:Client testDB = new ({
    url: "jdbc:mysql://localhost:3306/test",
    username: "root",
    password: "rootroot"
});

// curl -ni localhost:8080/StudentRepo/getStudentRecordPreferred?id=1
service StudentRepo on new http:Listener(8080) {
    resource function getStudentRecord(http:Caller caller, http:Request req) returns @tainted error? {
        var res = new http:Response();

        string? studentId = req.getQueryParamValue("id");
        var selectRet = testDB->select("SELECT * FROM the_tab WHERE id = " + <string>studentId, ());
        var tb = check selectRet;
        if (tb.hasNext()) {
            res.setPayload("Found!");
        } else {
            res.setPayload("Not Found!");
        }
        tb.close();
        var resStatus = caller->respond(res);
    }

    resource function getStudentRecordPreferred(http:Caller caller, http:Request req) returns @tainted error? {
        var res = new http:Response();

        string? studentId = req.getQueryParamValue("id");
        var selectRet = testDB->select("SELECT * FROM the_tab  WHERE id = ?", (), check 'int:fromString(<string>studentId));

        var tb = check selectRet;
        if (tb.hasNext()) {
            res.setPayload("Found!");
        } else {
            res.setPayload("Not Found!");
        }
        tb.close();
        var resStatus = caller->respond(res);
    }
}
