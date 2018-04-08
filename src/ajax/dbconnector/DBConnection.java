package ajax.dbconnector;

import java.sql.*;

public class DBConnection {

	// JDBC driver name and database URL
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost:3306/jspajax?autoReconnect=true&useSSL=false";

	// Database credentials
	static final String USER = "root";
	static final String PASS = "youmekko";

	private static Connection conn;

	// 데이테베이스 커넥션 객체 생성 메소드
	public static Connection connect() throws ClassNotFoundException, SQLException {

		// STEP 2: Register JDBC driver
		Class.forName(JDBC_DRIVER);
		// STEP 3: Open a connection
		conn = DriverManager.getConnection(DB_URL, USER, PASS);

		return conn;
	}

	// 데이테베이스 커넥션 객체 소멸 메소드
	public static void close() throws SQLException {
		if (conn != null) {
			conn.close();
		}
	}

}