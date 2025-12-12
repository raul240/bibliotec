import mysql from "mysql2/promise";

export const db = await mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "raulbrantes",
    database: "dblivraria", 
    authPlugins: {
        mysql_gssapi_client:() => () => "",
        mysql_native_password: () => () => "root"
    }

});
